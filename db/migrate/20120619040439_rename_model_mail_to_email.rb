class RenameModelMailToEmail < ActiveRecord::Migration
  def change
    rename_table :mails, :emails
    rename_column :transactions, :mail_id, :email_id
  end
end
