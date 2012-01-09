class ParticipationController < ApplicationController
   
  # GET /participation
  # GET /participation.json
  def index
    @users  = User.all
    @expenses = Expense.all

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
      #format.js { @is_relation = false, @eid = params[:eid], @uid = params[:uid] }
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
      #format.js { @is_relation = true, @eid = params[:eid], @uid = params[:uid] }
      format.js { render nothing: true }
    end
  end

end
