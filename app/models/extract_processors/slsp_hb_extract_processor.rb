class SlspHbExtractProcessor < ExtractProcessor
  # Homebanking SLSP
  # http://www.slsp.sk/downloads/format_hb_vzor.pdf

  def self.extract_all
    mails = Mails.find_all_by_state(:decoded)

    if mails.nil?
      # Ziadne volne maily na spracovanie
    else

      mails.each do |mail|
        extract_one(mail)
      end

    end
  end


  private

    def self.extract_one(mail)
      if mail.decoded_attachment.blank?
        # Nema ziadnu prilohu
      else

        mail.decoded_attachment.lines.each do |line|
          pl = line.split(';')
          if pl.length > 0
            Transaction.create do |t|
              t.email_id = mail.id
              t.datum_transakcie = pl[0]
              t.predcislo_uctu = pl[1]
              t.cislo_uctu = pl[2]
              t.predcislo_protiuctu = pl[3]
              t.cislo_protiuctu = pl[4]
              t.kod_banky = pl[5] # neznama premenna
              t.nazov_protiuctu = pl[6]
              t.suma = pl[7]
              t.kod_meny = pl[8]
              t.konstanta = pl[9]
              t.zostatok = pl[10]
              t.nazov_transakcie = pl[11]
              t.variabilny_symbol = pl[12]
              t.konstantny_symbol = pl[13]
              t.specificky_symbol = pl[14]
              t.indikator_storna = pl[15]
              t.poznamka = pl[16]
              t.poradove_cislo_vypisu = pl[17]
              t.identifikacia_protiuctu = pl[18] + pl[19] + pl[20] + pl[21]
              t.sprava_pre_prijemcu = pl[22] + pl[23] + pl[24] + pl[25]
              t.unparsed_transaction = line
            end
          end

        end

      end
    end

end