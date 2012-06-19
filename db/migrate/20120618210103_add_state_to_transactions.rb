class AddStateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :state, :string, default: :fail
  end
end
