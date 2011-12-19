class ParticipationController < ApplicationController
   
  # GET /participation
  # GET /participation.json
  def index
    @users  = User.all
    @expenses = Expense.all

    authorize! :index, Participation

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # POST /participation/1/2
  # POST /participation/1/2.json
  def add
    @participation = Participation.new(expense_id: params[:eid], user_id: params[:uid])
    authorize! :add, @participation

    User.find(params[:uid]).expenses  << Expense.find(params[:eid])
    
    respond_to do |format|
      format.html { redirect_to participation_url }
      #format.js { @is_relation = false, @eid = params[:eid], @uid = params[:uid] }
      format.js { render nothing: true }
    end
  end

  # DELETE /participation/1/2
  # DELETE /participation/1/2.json
  def delete
    @participation = Participation.where(expense_id: params[:eid], user_id: params[:uid]).first
    authorize! :delete, @participation

    User.find(params[:uid]).expenses .delete(Expense.find(params[:eid]))

    respond_to do |format|
      format.html { redirect_to participation_url }
      #format.js { @is_relation = true, @eid = params[:eid], @uid = params[:uid] }
      format.js { render nothing: true }
    end
  end

end
