require 'net/imap'
#require 'tempfile'
#require 'zip/zip'

class Mail < ActiveRecord::Base
  has_many :transactions

  public 

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
      
      imap.search(['ALL']).each do |msg_id|
        data = imap.fetch(msg_id, ['ENVELOPE', 'UID', 'BODY', 'BODY[2]'])[0]

        msg = []
        msg << msg_id
        msg << data.attr['ENVELOPE']
        msg << data.attr['UID']
        msg << data.attr['BODY']
        msg << data.attr['BODY[2]']

        msgs << msg

        attachment = data.attr['BODY[2]']

        if attachment

          dir = Dir.mktmpdir('team_ucto')

          binattachment = attachment.unpack('m')[0]

          tmp = Tempfile.new('mail.zip', dir, encoding: 'ascii-8bit')
          tmp.binmode
          tmp.write(binattachment)
          tmp.close

          # rozbali zip tmp.path zaheslovany heslom 'heslo' do adresara dir
          # a prepise pripadne existujuce subory (situacia by nemala nastat)
          q = Kernel.system('M:\\devkit\\bin\\unzip.exe', '-P', 'heslo', '-o', '-d', dir, tmp.path)
          msgs << [q, dir, tmp.path, $?]
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
