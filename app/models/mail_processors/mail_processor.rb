class MailProcessor

  def self.download_mails(test = false)
    if test
      mail_processor::test_download_new_mails
    else
      mail_processor::download_new_mails
    end
  end

  private

    def self.mail_processor
      APP_CONFIG['processors']['mail'].constantize
    end

end