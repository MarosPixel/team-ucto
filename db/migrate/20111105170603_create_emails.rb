class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :state
      t.text   :content
      t.text   :unparsed_content
      t.timestamps
    end
  end
end
