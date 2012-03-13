class ParticipationController < ApplicationController
  # manual authorization
   
  # GET /participation
  # GET /participation.json
  def index

    @users  = User.all
    @expenses = Expense.paginate(page: params[:page], per_page: 9, order: 'start_at DESC')
    @table_groups = table_groups(@expenses)

    authorize! :index, ParticipationPosting

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # POST /participation/1/2
  # POST /participation/1/2.json
  def add
    @participation = ParticipationPosting.new(expense_id: params[:eid], user_id: params[:uid])
    
    begin
      authorize! :add, @participation

      User.find(params[:uid]).expenses  << Expense.find(params[:eid])

      nastav_cenu(params[:eid], params[:uid])

      respond_to do |format|
        format.html { redirect_to participations_url }
        format.js { render nothing: true }
      end

    rescue
      respond_to do |format|
        format.js { head :bad_request }
      end
    end
  end

  # DELETE /participation/1/2
  # DELETE /participation/1/2.json
  def delete
    @participation = ParticipationPosting.where(expense_id: params[:eid], user_id: params[:uid]).first

    begin
      authorize! :delete, @participation

      User.find(params[:uid]).expenses.delete(Expense.find(params[:eid]))

      nastav_cenu(params[:eid], params[:uid], false)

      respond_to do |format|
        format.html { redirect_to participations_url }
        format.js { render nothing: true }
      end

    rescue
      respond_to do |format|
        format.js { head :bad_request }
      end
    end
  end

  private

    def table_groups(expenses)
      previous_month = ''
      group_id = -1
      groups = []
      expenses.each do |expense|
        if previous_month != expense.start_at.mon()
          previous_month = expense.start_at.mon()
          group_id += 1
          groups[group_id] = []
          groups[group_id][0] = [] # sub groups
          groups[group_id][1] = expense.start_at.strftime('%B %Y') # title (January 2012)
          groups[group_id][2] = 'head_color_' + expense.start_at.mon().to_s # color_class
        end
        groups[group_id][0] << expense
      end  
      groups
    end

    def nastav_cenu(expense_id, user_id, is_update = true)
      expense = Expense.find(expense_id)
      if expense.type == 'Training'
        # pri treningu je v "player_fee" cena pre jedneho hraca
        ParticipationPosting.where(expense_id: expense_id, user_id: user_id).first.update_attributes(price: -expense.player_fee) if is_update
      else # 'Tournament' a 'OtherExpense'
        # pri ostatnych udalostiach sa cena pre jedneho hraca vyrata ako 
        # "player_fee za kazdeho + team_fee na pocet_hracov"
        price = expense.player_fee + (expense.team_fee / expense.users.count)
        # cenu treba zmenit vsetkym participujucim pouzivatelom
        ParticipationPosting.where(expense_id: expense_id).update_all(price: -price)
        # cenu treba upravit aj danemu postingu expensu, lebo je zavisla od poctu prihlasenych hracov
        price = expense.team_fee + (expense.player_fee * expense.users.count)
        ExpensePosting.where(expense_id: expense_id).first.update_attributes(price: -price)
      end
    end

end
