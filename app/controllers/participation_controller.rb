class ParticipationController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users  = User.all
    @events = Event.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  def add
    @participation = User.find(params[:uid]).events
    @participation << Event.find(params[:eid])

    respond_to do |format|
      format.html { redirect_to participation_url }
      format.js { @is_relation = true, @eid = params[:eid], @uid = params[:uid] }
      # format.js { render nothing: true }
    end
  end

  def delete
    User.find(params[:uid]).events.delete(Event.find(params[:eid]))

    respond_to do |format|
      format.html { redirect_to participation_url }
      format.js { @is_relation = false, @eid = params[:eid], @uid = params[:uid] }
      # format.js { render nothing: true }
    end
  end

end
