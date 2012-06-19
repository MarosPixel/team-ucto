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

ActiveRecord::Schema.define(:version => 20120619134408) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "emails", :force => true do |t|
    t.string   "imap_id"
    t.text     "content"
    t.string   "state"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "received_at"
    t.string   "send_by"
    t.text     "envelope"
    t.text     "attachment"
    t.text     "decoded_attachment"
    t.string   "file_name"
  end

  add_index "emails", ["imap_id"], :name => "index_mails_on_imap_id"

  create_table "expenses", :force => true do |t|
    t.string   "type",        :null => false
    t.string   "name"
    t.date     "start_at"
    t.date     "end_at"
    t.decimal  "total_price"
    t.decimal  "team_fee"
    t.decimal  "player_fee"
    t.integer  "creator_id"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "expenses", ["type"], :name => "index_expenses_on_type"

  create_table "postings", :force => true do |t|
    t.string   "type"
    t.integer  "expense_id"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.decimal  "price",          :precision => 8, :scale => 2
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postings", ["expense_id"], :name => "index_postings_on_expense_id"
  add_index "postings", ["transaction_id"], :name => "index_postings_on_transaction_id"
  add_index "postings", ["type"], :name => "index_postings_on_type"
  add_index "postings", ["user_id"], :name => "index_postings_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "email_id"
    t.string   "datum_transakcie",        :limit => 12
    t.string   "predcislo_uctu",          :limit => 6
    t.string   "cislo_uctu",              :limit => 10
    t.string   "predcislo_protiuctu",     :limit => 6
    t.string   "cislo_protiuctu",         :limit => 10
    t.string   "kod_banky",               :limit => 4
    t.string   "nazov_protiuctu",         :limit => 20
    t.string   "suma",                    :limit => 20
    t.string   "kod_meny",                :limit => 3
    t.string   "konstanta",               :limit => 21
    t.string   "zostatok",                :limit => 20
    t.string   "nazov_transakcie",        :limit => 50
    t.integer  "variabilny_symbol",       :limit => 10
    t.integer  "konstantny_symbol",       :limit => 4
    t.integer  "specificky_symbol",       :limit => 10
    t.integer  "indikator_storna",        :limit => 1
    t.string   "poznamka",                :limit => 30
    t.integer  "poradove_cislo_vypisu",   :limit => 3
    t.text     "identifikacia_protiuctu"
    t.text     "sprava_pre_prijemcu"
    t.text     "unparsed_transaction"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.string   "state",                                 :default => "fail"
  end

  add_index "transactions", ["email_id"], :name => "index_transactions_on_email_id"

  create_table "users", :force => true do |t|
    t.integer  "vs"
    t.string   "username",                                                    :null => false
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
    t.boolean  "is_approved",                           :default => false,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true
  add_index "users", ["vs"], :name => "index_users_on_vs", :unique => true

end
