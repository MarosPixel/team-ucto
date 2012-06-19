class SlspHbExtractProcessor < ExtractProcessor
  # Homebanking SLSP
  # http://www.slsp.sk/downloads/format_hb_vzor.pdf

  def self.extract_all
    mails = Email.find_all_by_state(:decoded)

    if mails.blank?
      Rails.logger.info "Ziadne volne maily na spracovanie."
    else

      mails.each do |mail|
        extract_one(mail)
      end

    end
  end

  def self.extract_one(mail)
    if mail.decoded_attachment.blank?
      Rails.logger.info "Mail #{mail.id} nema prilohu."
    else

      mail.decoded_attachment.lines.each do |line|

        pl = line.split(';')
        if pl.length > 0
          Transaction.create(
            email_id: mail.id,
            datum_transakcie: pl[0],
            predcislo_uctu: pl[1],
            cislo_uctu: pl[2],
            predcislo_protiuctu: pl[3],
            cislo_protiuctu: pl[4],
            kod_banky: pl[5], # neznama premenna
            nazov_protiuctu: pl[6],
            suma: pl[7],
            kod_meny: pl[8],
            konstanta: pl[9],
            zostatok: pl[10],
            nazov_transakcie: pl[11],
            variabilny_symbol: pl[12],
            konstantny_symbol: pl[13],
            specificky_symbol: pl[14],
            indikator_storna: pl[15],
            poznamka: pl[16],
            poradove_cislo_vypisu: pl[17],
            identifikacia_protiuctu: pl[18] + pl[19] + pl[20] + pl[21],
            sprava_pre_prijemcu: pl[22] + pl[23] + pl[24] + pl[25],
            unparsed_transaction: line,
            state: :unprocessed
          )

          mail.update_attribute :state, :extracted
        end

      end

    end
  end

end