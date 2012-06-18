# encoding: utf-8

class MailsController < ApplicationController

  # GET /mails
  def index
    @mails = Mail.all

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # GET /mail/1
  def show
    @mail = Mail.find(params[:id])

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # DELETE /mail/1
  def destroy
    Mail.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to mails_url, notice: "Mail #{params[:id]} bol zmazaný." }
    end
  end

  # DELETE /mails
  def destroy_all
    Mail.destroy_all

    respond_to do |format|
      format.html { redirect_to mails_url, notice: "Všetky maily boli zmazané." }
    end
  end

end
