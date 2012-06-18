class DownloadProcessor

  def self.download_all(test = false)
    if test
      download_processor::test_download_all
    else
      download_processor::download_all
    end
  end

  private

    def self.download_processor
      APP_CONFIG['processors']['download'].constantize
    end

end