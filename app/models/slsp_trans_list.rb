class SlspTransList < ActiveRecord::Base

public

  # Homebanking SLSP
  def self.extract_hb(file_name, email_id = nil)
    file = File.open(file_name)

    Transaction.delete_all

    file.lines.each do |line|
      parsed_line = line.split(';')
      if parsed_line.length > 0
        Transaction.create do |t|
          t.email_id = email_id
          t.datum_transakcie = parsed_line[0]
          t.predcislo_uctu = parsed_line[1]
          t.cislo_uctu = parsed_line[2]
          t.predcislo_protiuctu = parsed_line[3]
          t.cislo_protiuctu = parsed_line[4]
          t.kod_banky = parsed_line[5] # neznama premenna
          t.nazov_protiuctu = parsed_line[6]
          t.suma = parsed_line[7]
          t.kod_meny = parsed_line[8]
          t.konstanta = parsed_line[9]
          t.zostatok = parsed_line[10]
          t.nazov_transakcie = parsed_line[11]
          t.variabilny_symbol = parsed_line[12]
          t.konstantny_symbol = parsed_line[13]
          t.specificky_symbol = parsed_line[14]
          t.indikator_storna = parsed_line[15]
          t.poznamka = parsed_line[16]
          t.poradove_cislo_vypisu = parsed_line[17]
          t.identifikacia_protiuctu = parsed_line[18] + parsed_line[19] + parsed_line[20] + parsed_line[21]
          t.sprava_pre_prijemcu = parsed_line[22] + parsed_line[23] + parsed_line[24] + parsed_line[25]
          t.unparsed_transaction = line
        end
      end
    end

    'spracovane'
  end

end
