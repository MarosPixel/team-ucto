class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string   :type,        null: false
      t.string   :name
      t.date     :start_at
      t.date     :end_at
      t.decimal  :total_price, precision: 8, scale: 2, default: 0
      t.decimal  :team_fee,    precision: 8, scale: 2, default: 0
      t.decimal  :player_fee,  precision: 8, scale: 2, default: 0
      t.integer  :creator_id
      t.datetime :locked_at
      t.timestamps
      t.text     :description
    end
    
    add_index :expenses, :type
  end
end
