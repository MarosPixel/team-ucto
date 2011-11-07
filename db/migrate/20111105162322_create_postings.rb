class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string  :type,          null: false
      t.integer :event_id
      t.integer :user_id
      t.integer :transaction_id
      t.decimal :price,         precision: 6, scale: 2
      t.integer :creator_id
      t.timestamps
    end
  end
end
