class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.string  :type,          null: false
      t.integer :event_id
      t.integer :user_id
      t.integer :transaction_id
      t.decimal :price,         precision: 8, scale: 2
      t.integer :creator_id
      t.timestamps
    end
    add_index :postings, :type
    add_index :postings, :event_id
    add_index :postings, :user_id
    # add_index :postings, :transaction_id
  end
end
