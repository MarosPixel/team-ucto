class AttachmentProcessor

  def self.decode_attachments
    attachment_processor::decode_attachments
  end

  private

    def self.attachment_processor
      APP_CONFIG['processors']['attachment'].constantize
    end

end