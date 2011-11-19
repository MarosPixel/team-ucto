class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :type,        null: false
      t.string   :name
      t.datetime :start_at
      t.datetime :end_at
      t.decimal  :total_price, precision: 8, scale: 2
      t.decimal  :team_fee,    precision: 8, scale: 2
      t.decimal  :player_fee,  precision: 8, scale: 2
      t.integer  :creator_id
      t.datetime :locked_at
      t.timestamps
      t.text     :description
    end
    
    add_index :events, :type
  end
end
