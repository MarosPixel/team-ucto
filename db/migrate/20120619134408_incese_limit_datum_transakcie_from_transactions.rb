class InceseLimitDatumTransakcieFromTransactions < ActiveRecord::Migration
  def up
    change_column :transactions, :datum_transakcie, :string, limit: 12
  end

  def down
    change_column :transactions, :datum_transakcie, :string, limit: 10
  end
end
