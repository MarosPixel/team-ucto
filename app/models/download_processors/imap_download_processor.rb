require 'net/imap'

class ImapDownloadProcessor < DownloadProcessor

  # imap settings
  IMAP_IMAP = 'imap.gmail.com'
  IMAP_PORT = 993
  IMAP_SSL  = true
  IMAP_NAME = 'ww784501@gmail.com'
  IMAP_PASS = 'ww7845013'

  # spracovavame iba maily poslane z adresy
  SENDER_MAIL = 'dopaze@gmail.com'

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

    def self.test_download_all
      imap = imap_connect

      msgs = []
      max_imap_id = Email::get_max_imap_id
      max_receive_date = Email::get_max_receive_date

      imap.select('INBOX')
      imap.search(['FROM', SENDER_MAIL, 'SINCE', max_receive_date]).each do |msg_id|
        data = imap.fetch(msg_id, ['ENVELOPE', 'UID', 'BODY', 'BODY[2]'])[0]

        uid = data.attr['UID']

        if uid > max_imap_id
          msg = []
          msg << uid
          msg << data.attr['ENVELOPE']
          msg << data.attr['BODY']
          msg << data.attr['BODY[2]']
          msg << :saved

          msgs << msg
        end
      end

      imap_disconnect(imap)

      msgs << [SENDER_MAIL, max_receive_date]
      msgs
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
