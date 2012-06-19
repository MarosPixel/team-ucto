class ZipWinDecodeProcessor < DecodeProcessor
  # rozbalovanie archivu pre windows
  # na rozbalenie je potrebna externa UNZIP kniznica (unzip.exe)

  # settings
  TMP_DIR = 'team_ucto'
  ZIP_PASS = 'secret_pass'
  UNZIP_PATH = 'M:\\devkit\\bin\\unzip.exe'

  def self.decode_one(mail)
    binattachment = mail.attachment.unpack('m')[0]

    # Dir.mktmpdir(TMP_DIR_NAME) do |dir_path|
    dir_path = Dir.mktmpdir(TMP_DIR)

      tmp = Tempfile.new('mail.zip', dir_path, encoding: 'ascii-8bit')
      tmp.binmode
      tmp.write(binattachment)
      tmp.close

      # rozbali zip tmp.path zaheslovany heslom 'heslo' do adresara dir_path
      # a prepise pripadne existujuce subory (situacia by nemala nastat)
      if Kernel.system(UNZIP_PATH, '-P', ZIP_PASS, '-o', '-d', dir_path, tmp.path)
        files = Dir.glob("#{dir_path}/*.txt")

        mail.file_name = File.basename(files[0])
        mail.decoded_attachment = File.open(files[0]).to_a.join
        mail.state = :decoded
        mail.save
      end

      tmp.unlink

    # end
  end

end
