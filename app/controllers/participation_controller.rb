class ParticipationController < ApplicationController
  authorize_resource
  
  # GET /participation
  # GET /participation.json
  def index
    @users  = User.all
    @expenses = Expense.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # POST /participation/1/2
  # POST /participation/1/2.json
  def add
    get_user_expenses << get_expense

    respond_to do |format|
      format.html { redirect_to participation_url }
      #format.js { @is_relation = false, @eid = params[:eid], @uid = params[:uid] }
      format.js { render nothing: true }
    end
  end

  # DELETE /participation/1/2
  # DELETE /participation/1/2.json
  def delete
    get_user_expenses.delete(get_expense)

    respond_to do |format|
      format.html { redirect_to participation_url }
      #format.js { @is_relation = true, @eid = params[:eid], @uid = params[:uid] }
      format.js { render nothing: true }
    end
  end

  private

    def get_user_expenses
      User.find(params[:uid]).expenses 
    end

    def get_expense
      Expense.find(params[:eid])
    end

end
