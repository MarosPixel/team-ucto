class DecodeProcessor

  def self.decode_all
    mails = Email.find_all_by_state(:saved)

    if mails.blank?
      # "Ziadne maily na spracovanie"
    else

      mails.each do |mail|
        decode_processor::decode_one(mail)
      end

    end
  end

private

  def self.decode_processor
    APP_CONFIG['processors']['decode'].constantize
  end

end