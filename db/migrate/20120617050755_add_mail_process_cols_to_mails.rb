class AddMailProcessColsToMails < ActiveRecord::Migration
  def change
    add_column :mails, :received_at,  :datetime
    add_column :mails, :send_by,      :string
    add_column :mails, :envelope,     :text
    add_column :mails, :attachment,   :text

    add_index :mails, :imap_id
  end
end
