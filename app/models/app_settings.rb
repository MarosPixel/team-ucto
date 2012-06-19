class AppSettings < ActiveRecord::Base
  attr_accessible :sender_mail, :zip_pass, :imap_host, :imap_port, :imap_ssl, :imap_name, :imap_pass

  def self.sender_mail
    AppSettings.first.sender_mail
  end

  def self.zip_pass
    AppSettings.first.zip_pass
  end

  def self.imap_host
    AppSettings.first.imap_host
  end

  def self.imap_port
    AppSettings.first.imap_port
  end

  def self.imap_ssl
    AppSettings.first.imap_ssl
  end

  def self.imap_name
    AppSettings.first.imap_name
  end
  
  def self.imap_pass
    AppSettings.first.imap_pass
  end
end
