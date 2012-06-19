require 'net/imap'

class ImapDownloadProcessor < DownloadProcessor

  # imap settings
  IMAP_IMAP = AppSettings::imap_host
  IMAP_PORT = AppSettings::imap_port
  IMAP_SSL  = AppSettings::imap_ssl
  IMAP_NAME = AppSettings::imap_name
  IMAP_PASS = AppSettings::imap_pass

  # spracovavame iba maily poslane z adresy
  SENDER_MAIL = AppSettings::sender_mail

  public

    def self.download_all
      mail_count = 0

      imap = imap_connect

      max_imap_id = Email::get_max_imap_id
      max_receive_date = Email::get_max_receive_date

      # vyberat spravy iba od sendera = SENDER_MAIL a
      # ktorych cas dorucenia je vacsii ako mam najvyssie ulozene v db
      imap.select('INBOX')
      imap.search(['FROM', SENDER_MAIL, 'SINCE', max_receive_date]).each do |msg_id|
        data = imap.fetch(msg_id, ['ENVELOPE', 'UID', 'BODY', 'BODY[2]'])[0]

        uid = data.attr['UID']

        if uid > max_imap_id
          Email.create(
            imap_id:    uid,
            received_at: data.attr['ENVELOPE'].date,
            send_by:    data.attr['ENVELOPE'].from[0].mailbox + '@' + data.attr['ENVELOPE'].from[0].host,
            envelope:   data.attr['ENVELOPE'],
            content:    data.attr['BODY'],
            attachment: data.attr['BODY[2]'],
            state:      :saved
          )
          mail_count += 1
        end
      end

      imap_disconnect(imap)

      mail_count
    end

  private

    def self.imap_connect
      imap = Net::IMAP.new(IMAP_IMAP, IMAP_PORT, IMAP_SSL)
      imap.login(IMAP_NAME, IMAP_PASS)
      imap
    end

    def self.imap_disconnect(imap)
      imap.logout()
      imap.disconnect()
    end

end
