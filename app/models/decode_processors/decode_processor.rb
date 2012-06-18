class DecodeProcessor

  def self.decode
    decode_processor::decode
  end

  private

    def self.decode_processor
      APP_CONFIG['processors']['decode'].constantize
    end

end