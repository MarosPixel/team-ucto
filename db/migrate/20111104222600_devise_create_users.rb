class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.integer  :vs,             null: false
      t.string   :name,           null: false, default: ""
      t.database_authenticatable  null: false
      t.string   :roles,          null: false, default: "member"
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable lock_strategy: :none, unlock_strategy: :none
      t.timestamps
    end

    add_index :users, :name,                 unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    drop_table :users
  end
end
