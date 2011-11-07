class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :event_type,  null: false, default: 'without_date'
      t.string   :name
      t.datetime :start_at
      t.datetime :end_at
      t.decimal  :total_price, precision: 6, scale: 2
      t.decimal  :team_fee,    precision: 6, scale: 2
      t.decimal  :player_fee,  precision: 6, scale: 2
      t.integer  :creator_id
      t.datetime :locked_at
      t.timestamps
      t.text     :description
    end
  end
end
