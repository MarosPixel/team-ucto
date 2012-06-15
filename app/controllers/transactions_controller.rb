class TransactionsController < ApplicationController
  authorize_resource

  # GET /transactions/
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postings }
    end
  end

  # GET /transactions/1
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

end
