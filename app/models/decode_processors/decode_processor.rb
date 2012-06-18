class DecodeProcessor

  def self.decode_all
    decode_processor::decode_all
  end

  private

    def self.decode_processor
      APP_CONFIG['processors']['decode'].constantize
    end

end