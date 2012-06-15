class TransactionUpdate < ActiveRecord::Migration
  def up
    drop_table :transactions
    create_table :transactions do |t|
      t.integer  :email_id
      t.string   :datum_transakcie,       limit: 10
      t.string   :predcislo_uctu,         limit: 6
      t.string   :cislo_uctu,             limit: 10
      t.string   :predcislo_protiuctu,    limit: 6
      t.string   :cislo_protiuctu,        limit: 10
      t.string   :kod_banky,              limit: 4  # neoficialne pridane
      t.string   :nazov_protiuctu,        limit: 20
      t.string   :suma,                   limit: 20
      t.string   :kod_meny,               limit: 3
      t.string   :konstanta,              limit: 21
      t.string   :zostatok,               limit: 20
      t.string   :nazov_transakcie,       limit: 50
      t.integer  :variabilny_symbol,      limit: 10
      t.integer  :konstantny_symbol,      limit: 4
      t.integer  :specificky_symbol,      limit: 10
      t.integer  :indikator_storna,       limit: 1
      t.string   :poznamka,               limit: 30
      t.integer  :poradove_cislo_vypisu,  limit: 3
      t.text     :identifikacia_protiuctu
      t.text     :sprava_pre_prijemcu
      t.text     :unparsed_transaction
      t.timestamps
    end
    add_index :transactions, :email_id
  end

  def down
    drop_table :transactions
    create_table :transactions do |t|
      t.integer  :email_id,         null: false
      t.integer  :datum_transakcie
      t.integer  :predcislo_uctu
      t.integer  :cislo_uctu
      t.decimal  :suma,             precision: 8, scale: 2
      t.string   :kod_meny
      t.integer  :vs
      t.text     :poznamka
      t.text     :sprava_pre_prijemcu
      t.text     :unparsed_transaction
      t.timestamps
    end
    add_index :transactions, :email_id
  end
end
