# encoding: utf-8

class EmailsController < ApplicationController

  # GET /emails
  def index
    @mails = Email.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /email/1
  def show
    @mail = Email.find(params[:id])

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # DELETE /email/1
  def destroy
    Email.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to mails_url, notice: "Mail #{params[:id]} bol zmazaný." }
    end
  end

  # DELETE /emails
  def destroy_all
    Email.destroy_all

    respond_to do |format|
      format.html { redirect_to mails_url, notice: "Všetky maily boli zmazané." }
    end
  end

end
