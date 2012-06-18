#require 'tempfile'
#require 'zip/zip'

class ZipDecodeProcessor < DecodeProcessor
  # rozbalovanie archivu pre windows
  # na rozbalenie je potrebna externa UNZIP kniznica (unzip.exe)

  # settings
  TMP_DIR = 'team_ucto'
  ZIP_PASS = 'secret_pass'
  UNZIP_PATH = 'M:\\devkit\\bin\\unzip.exe'

  def self.decode
    mails = Mail.find_all_by_state(:saved)

    if mails.nil?
      # "Ziadne maily na spracovanie"
    else

      mails.each do |mail|
        decode_one(mail)
      end

    end
  end

  def self.decode_one(mail)
    # Dir.mktmpdir(TMP_DIR_NAME) do |dir_path|
    dir_path = Dir.mktmpdir(TMP_DIR)

      binattachment = mail.attachment.unpack('m')[0]

      tmp = Tempfile.new('mail.zip', dir_path, encoding: 'ascii-8bit')
      tmp.binmode
      tmp.write(binattachment)
      tmp.close

      # rozbali zip tmp.path zaheslovany heslom 'heslo' do adresara dir_path
      # a prepise pripadne existujuce subory (situacia by nemala nastat)
      if Kernel.system(UNZIP_PATH, '-P', ZIP_PASS, '-o', '-d', dir_path, tmp.path)
        files = Dir.glob("#{dir_path}/*.txt")

        mail.file_name = File.basename(files[0])
        mail.decoded_attachment = File.open(files[0]).to_a[0]
        mail.state = :decoded
        mail.save
      end

      tmp.unlink

    # end
  end

end