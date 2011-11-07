# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111105170603) do

  create_table "emails", :force => true do |t|
    t.string   "state"
    t.text     "content"
    t.text     "unparsed_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "type",                                      :null => false
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.decimal  "total_price", :precision => 6, :scale => 2
    t.decimal  "team_fee",    :precision => 6, :scale => 2
    t.decimal  "player_fee",  :precision => 6, :scale => 2
    t.integer  "user_id"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "postings", :force => true do |t|
    t.string   "type",                                         :null => false
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.decimal  "price",          :precision => 6, :scale => 2
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "email_id",                                           :null => false
    t.integer  "datum_transakcie"
    t.integer  "predcislo_uctu"
    t.integer  "cislo_uctu"
    t.decimal  "suma",                 :precision => 6, :scale => 2
    t.string   "kod_meny"
    t.integer  "vs"
    t.text     "poznamka"
    t.text     "sprava_pre_prijemcu"
    t.text     "unparsed_transaction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "vs",                                                          :null => false
    t.string   "name",                                  :default => "",       :null => false
    t.string   "email",                                 :default => "",       :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "role",                                  :default => "member", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
