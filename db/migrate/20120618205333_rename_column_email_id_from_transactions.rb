class RenameColumnEmailIdFromTransactions < ActiveRecord::Migration
  def up
    rename_column :transactions, :email_id, :mail_id
  end

  def down
    rename_column :transactions, :mail_id, :email_id
  end
end
