# encoding: utf-8

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

  # DELETE /transaction/1
  def destroy
    Transaction.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transakcia #{params[:id]} bola úspešene zmazaná." }
    end
  end

  # DELETE /transactions
  def destroy_all
    Transaction.destroy_all

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Všetky transakcie boli úspešene zmazané." }
    end
  end

end
