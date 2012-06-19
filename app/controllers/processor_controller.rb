# encoding: utf-8

class ProcessorController < ApplicationController
  skip_before_filter :authenticate_user!, only: :start 
  
     # GET /process
  def index
    do_download(true)

    render nothing: true
  end 

  # GET /process/start
  def start
    do_download(true)

    redirect_to emails_url, notice: "Finished."
  end

  # GET /process/download
  def download
    count = do_download

    redirect_to emails_url, notice: "Sťahovanie ukončené. Počet nových emailov: #{count}"
  end

  # GET /process/decode
  def decode
    do_decode

    redirect_to emails_url, notice: "Decoded."
  end

  # GET /process/decode
  def extract
    do_extract

    redirect_to emails_url, notice: "Extracted."
  end

  # GET /process/assign
  def assign
    do_assign

    redirect_to emails_url, notice: "Assigned."
  end


private

  # GET /process/download
  def do_download(go_next = false)
    mail_count = DownloadProcessor::download_all
    do_decode(true) if go_next

    mail_count
  end

  # GET /process/decode
  def do_decode(go_next = false)
    DecodeProcessor::decode_all
    
    do_extract(true) if go_next
  end

  # GET /process/decode
  def do_extract(go_next = false)
    ExtractProcessor::extract_all
    
    do_assign if go_next
  end

  # GET /process/assign
  def do_assign
    Email::assign_all
  end

end
