class ZipUnixDecodeProcessor < DecodeProcessor
  # rozbalovanie archivu pre linux
  # na rozbalovanie je potrebna kniznica libzip

  # settings
  ZIP_PASS = AppSettings::zip_pass

  def self.decode_one(mail)
    binattachment = mail.attachment.unpack('m')[0]
    
    Zip::Archive.open_buffer(binattachment) do |ar|
      ar.decrypt(ZIP_PASS)

      ar.each do |f|
        mail.file_name = f.name
        mail.decoded_attachment = f.read
        mail.state = :decoded
        mail.save
      end
    end

  end

end
