class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer  :vs
      t.string   :username, null: false, default: ""

      ## [devise] Database authenticatable
      t.string   :email,              null: false, default: ""
      t.string   :encrypted_password, null: false, default: ""

      t.string   :role, null: false, default: "member"

      ## [devise] Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## [devise] Rememberable
      t.datetime :remember_created_at

      ## [devise] Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.boolean  :is_approved, null: false, default: false
      t.timestamps
    end
    
    add_index :users, :vs,                   unique: true
    add_index :users, :username,             unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
