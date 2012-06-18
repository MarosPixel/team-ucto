class ExtractProcessor

  def self.extract
    extract_processor::extract_all
  end

  private

    def extract_processor
      APP_CONFIG['processors']['extract'].constantize
    end

end