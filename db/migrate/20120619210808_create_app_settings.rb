class CreateAppSettings < ActiveRecord::Migration
  def change
    create_table :app_settings do |t|
      # Vseobecne nastavenia
      t.string  :sender_mail, default: ''
      t.string  :zip_pass, default: ''

      # IMAP settings
      t.string  :imap_host, default: 'imap.gmail.com'
      t.integer :imap_port, default: 993
      t.boolean :imap_ssl,  default: true
      t.string  :imap_name, default: ''
      t.string  :imap_pass, default: ''

      t.timestamps
    end

    AppSettings.create
  end
end
