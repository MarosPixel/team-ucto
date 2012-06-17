class AddColumnDecodedAttachmentToMails < ActiveRecord::Migration
  def change
    add_column :mails, :decoded_attachment, :text
    add_column :mails, :file_name, :string
  end
end
