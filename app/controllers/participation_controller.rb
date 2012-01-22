class ParticipationController < ApplicationController
   
  # GET /participation
  # GET /participation.json
  def index
    @users  = User.all
    @expenses = Expense.paginate(page: params[:page], per_page: 5, order: 'start_at DESC')
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
    # TODO try catch - Pristup zamietnuty
    authorize! :add, @participation

    User.find(params[:uid]).expenses  << Expense.find(params[:eid])
    
    respond_to do |format|
      format.html { redirect_to participations_url }
      format.js { render nothing: true }
    end
  end

  # DELETE /participation/1/2
  # DELETE /participation/1/2.json
  def delete
    @participation = ParticipationPosting.where(expense_id: params[:eid], user_id: params[:uid]).first
    authorize! :delete, @participation

    User.find(params[:uid]).expenses.delete(Expense.find(params[:eid]))

    respond_to do |format|
      format.html { redirect_to participations_url }
      format.js { render nothing: true }
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

end
