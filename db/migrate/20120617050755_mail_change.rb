class MailChange < ActiveRecord::Migration
  def up
    add_column :mails, :received_at,  :datetime
    add_column :mails, :send_by,      :string
    add_column :mails, :envelope,     :text
    add_column :mails, :attachment,   :text

    add_index :mails, :imap_id
  end

  def down
    remove_column :mails, :received_at
    remove_column :mails, :send_by
    remove_column :mails, :envelope
    remove_column :mails, :attachment

    remove_index :mails, :imap_id
  end
end
