class AttachmentProcessor

  def self.decode_attachments
    APP_CONFIG['processors']['attachment'].constantize::decode_attachments
  end

end