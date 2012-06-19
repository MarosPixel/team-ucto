class RenameColumnEmailIdFromTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :email_id, :mail_id
  end
end
