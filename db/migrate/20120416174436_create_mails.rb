class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string   :imap_id
      t.text     :content
      t.string   :state,  default: :fail
      
      t.timestamps
    end
  end
end
