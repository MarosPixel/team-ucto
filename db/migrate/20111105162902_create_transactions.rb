class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :email_id,            null: false
      t.integer :datum_transakcie
      t.integer :predcislo_uctu
      t.integer :cislo_uctu
      t.decimal :suma,                precision: 6, scale: 2
      t.string  :kod_meny
      t.integer :vs
      t.text    :poznamka
      t.text    :sprava_pre_prijemcu
      t.text    :unparsed_transaction
      t.timestamps
    end
  end
end
