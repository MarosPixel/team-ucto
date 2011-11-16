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
    @participation << Event.find(params[:eid]) if @participation.where(id: params[:eid]).first.nil?

    respond_to do |format|
      format.html { redirect_to participation_url, notice: 'User was successfully logged on to event.' }
    end
  end

  def delete
    User.find(params[:uid]).events.delete(Event.find(params[:eid]))

    respond_to do |format|
      format.html { redirect_to participation_url, notice: 'User was successfully logged out from event.'  }
    end
  end

end
