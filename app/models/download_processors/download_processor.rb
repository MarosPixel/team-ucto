class DownloadProcessor

  def self.download_all(test = false)
    download_processor::download_all
  end

private

  def self.download_processor
    APP_CONFIG['processors']['download'].constantize
  end

end