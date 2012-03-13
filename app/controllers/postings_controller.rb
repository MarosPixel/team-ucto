class PostingsController < ApplicationController
  # manual authorization

  # GET /postings/my
  def my
    authorize! :read_your, Posting

    @postings = Posting.where('user_id = ?', current_user.id)
    @balance = @postings.sum('price')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postings }
    end
  end

  # GET /postings/all
  def all
    authorize! :read_all, Posting

    @postings = Posting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postings }
    end
  end

  # GET /postings/team
  def team
    authorize! :read_team, Posting

    @postings = Posting.where("type <> 'ParticipationPosting'")
    @balance = @postings.sum('price')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postings }
    end
  end
end
