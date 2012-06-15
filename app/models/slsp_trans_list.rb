class SlspTransList < ActiveRecord::Base

public

  # Homebanking SLSP
  def self.extract_hb(file_name)
    file = File.open(file_name)

    Transaction.delete_all

    file.lines.each do |line|
      a = line.split(';')
      Transaction.create do |t|
        t.email_id = nil
        t.datum_transakcie = a[0]
        t.predcislo_uctu = a[1]
        t.cislo_uctu = a[2]
        t.predcislo_protiuctu = a[3]
        t.cislo_protiuctu = a[4]
        t.kod_banky = a[5] # neznama premenna
        t.nazov_protiuctu = a[6]
        t.suma = a[7]
        t.kod_meny = a[8]
        t.konstanta = a[9]
        t.zostatok = a[10]
        t.nazov_transakcie = a[11]
        t.variabilny_symbol = a[12]
        t.konstantny_symbol = a[13]
        t.specificky_symbol = a[14]
        t.indikator_storna = a[15]
        t.poznamka = a[16]
        t.poradove_cislo_vypisu = a[17]
        t.identifikacia_protiuctu = a[18] + a[19] + a[20] + a[21]
        t.sprava_pre_prijemcu = a[22] + a[23] + a[24] + a[25]
        t.unparsed_transaction = line
      end
    end

    'spracovane'
  end

end
