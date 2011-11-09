class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :state
      t.text   :content
      t.text   :unparsed_content
      t.timestamps
    end
    add_index :emails, :state
  end
end
