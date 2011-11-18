class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.integer  :creator_id
      t.string   :trackable_type, null: false
      t.integer  :trackable_id,   null: false
      t.string   :action,         null: false
      t.text     :comment
      t.datetime :created_at
    end
    add_index :action_logs, :creator_id
    add_index :action_logs, :trackable_type
    add_index :action_logs, :trackable_id
  end
end
