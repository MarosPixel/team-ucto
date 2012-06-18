class ExtractProcessor

  def self.extract_all
    extract_processor::extract_all
  end

  private

    def self.extract_processor
      APP_CONFIG['processors']['extract'].constantize
    end

end