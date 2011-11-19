class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer  :vs
      t.string   :username,       null: false
      t.database_authenticatable  null: false
      t.string   :role,           null: false, default: "member"
      t.recoverable
      t.rememberable
      t.trackable
      t.boolean  :is_approved,    null: false, default: false
      t.timestamps
    end
    
    add_index :users, :vs,                   unique: true
    add_index :users, :username,             unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
