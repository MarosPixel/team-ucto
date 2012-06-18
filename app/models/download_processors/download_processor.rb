class DownloadProcessor

  def self.download(test = false)
    if test
      download_processor::test_download
    else
      download_processor::download
    end
  end

  private

    def self.download_processor
      APP_CONFIG['processors']['download'].constantize
    end

end