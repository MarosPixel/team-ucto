require 'net/imap'
#require 'tempfile'
#require 'zip/zip'

class Mail < ActiveRecord::Base
  STATES = %w{ saved decoded parsed associated }

  has_many :transactions

  public 

    def self.get_max_imap_id
      max_id = Mail.maximum(:imap_id)
      if max_id.blank?
        0
      else
        max_id.to_i
      end
    end

    def self.get_max_receive_date(date_format = '%d-%b-%Y')
      max_date = Mail.maximum(:received_at)
      if max_date.nil?
        Time.parse('2000-01-01 00:00:00').strftime(date_format)
      else
        max_date.strftime(date_format)
      end
    end

    def self.download_new_mails
      msgs = []

      imap = Net::IMAP.new('imap.gmail.com', 993, true)
      imap.login('ww784501@gmail.com', 'ww7845013')

      imap.select('INBOX')

      # # TODO: vyberat spravy ktore maju unique_id vacsie ako je moje posledne ulozene v databaze
      # imap.search(['ALL']).each do |msg_id|

      #   data = imap.fetch(msg_id, ['UID', 'RFC822', 'BODY[HEADER.FIELDS (SUBJECT)]'])[0]

      #   msg = []
      #   msg << msg_id
      #   msg << data.attr['UID']
      #   msg << data.attr['BODY[HEADER.FIELDS (SUBJECT)]']
      #   msg << data.attr['RFC822'].to_s

      #   msgs << msg

      #   #imap.store(msg_id, '+FLAGS', [:Seen])
      # end
      
      imap.search(['FROM', 'dopaze@gmail.com', 'SINCE', '01-Jan-2000']).each do |msg_id|
        data = imap.fetch(msg_id, ['ENVELOPE', 'UID', 'BODY', 'BODY[2]'])[0]

        a = imap.fetch(msg_id, ["BODY[HEADER.FIELDS (DATE)]"])[0]

        msg = []
        # msg << data.attr['ENVELOPE'].date
        # msg << "#{data.attr['ENVELOPE'].from[0].mailbox}@#{data.attr['ENVELOPE'].from[0].host}"
        msg << data.attr['BODY']
        msg << data.attr['ENVELOPE']
        msg << data.attr['UID']
        msg << data.attr['BODY']
        msg << data.attr['BODY[2]']

        msgs << msg

        attachment = data.attr['BODY[2]']



        if attachment

          dir_path = Dir.mktmpdir('team_ucto')

          binattachment = attachment.unpack('m')[0]

          tmp = Tempfile.new('mail.zip', dir_path, encoding: 'ascii-8bit')
          tmp.binmode
          tmp.write(binattachment)
          tmp.close

          # rozbali zip tmp.path zaheslovany heslom 'heslo' do adresara dir
          # a prepise pripadne existujuce subory (situacia by nemala nastat)
          q = Kernel.system('M:\\devkit\\bin\\unzip.exe', '-P', 'secret_pass', '-o', '-d', dir_path, tmp.path)

          files = Dir.glob("#{dir_path}/*.txt")

          file_name = File.basename(files[0])
          file = File.open(files[0]).to_a[0]


          msgs << [file, q, dir_path, tmp.path, $?]
          tmp.unlink


          # # vytvorit docasny adresar
          # dir = Dir.mktmpdir('team_ucto')
          # # vytvorit docasny subor v docasom adresari
          # tmp = Tempfile.new("#{dir}/mail.zip",'wb+').write(attachment.unpack('m')[0])

          # # pridat unikatne id + zmazat subor
          # tmp = Tempfile.new("#{Rails.root}/tmp/mails/mail.zip",'wb+').write(attachment.unpack('m')[0])

          # # archive = File.open(tmp.path, "w") do |f|
          # #   f.write attachment.force_encoding("UTF-8")
          # # end

          # Zip::ZipFile.open(tmp.path) do |zip|

          #   priloha = zip.read("priloha.txt")

          # end

          # tmp.unlink

        end


      end

      imap.logout()
      imap.disconnect()

      msgs
    end

  private

    def do_process
    end

    def do_decrypt
    end

    def extract_attachment
    end

    def extract_transaction
    end

end
