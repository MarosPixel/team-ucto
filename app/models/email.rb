class Email < ActiveRecord::Base

  ## STAVY emailov
  # 1. saved      - po stiahnuti z emailoveho servera a ulozeni do db
  # 2. decoded    - po rozsifrovani, rozpakovania ulozeni prilohy emailu
  # 3. extracted  - po vyextrahovani transakcii z emailovej prilohy
  # 4. assigned   - priradeny, prebehla operacia priradenia transakcii priradenych k danemu emailu
  # 5. excluded   - uzivatelom oznaceny ako neaktivy pri automatickych spracovaniach
  # 6. fail       - vynimocny stav, pouziva sa na oznacenie chybneho zaznamu na upozornenie spravcu
  STATES = %w{ saved decoded extracted assigned excluded fail }

  has_many :transactions, dependent: :destroy



  ## class methods

  def self.get_max_imap_id
    max_id = Email.maximum(:imap_id)
    if max_id.blank?
      0
    else
      max_id.to_i
    end
  end

  def self.get_max_receive_date(date_format = '%d-%b-%Y')
    max_date = Email.maximum(:received_at)
    if max_date.nil?
      Time.parse('2000-01-01 00:00:00').strftime(date_format)
    else
      max_date.strftime(date_format)
    end
  end

  def self.assign_all
    mails = Email.find_all_by_state(:extracted)

    if mails.blank?
      # ziadne maily na spracovanie
    else
      mails.each do |mail|
        mail.assign_transactions
      end
    end
  end



  ## instace methods

  def assign_transactions
    if transactions.blank?
      # ziadne trasakcie na spracovanie
    else
      transactions.each do |transaction|
        transaction.assign
      end
      self.state = :assigned
      save
    end
  end

end
