class Transaction < ActiveRecord::Base

  ##    STAVY transakcii
  # 1. unprocessed  - nespracovavana, caka na automaticke priradenie
  # 2. assigned     - uspesne priradena pouzivatelovi
  # 3. unresolved   - nepodarilo sa automaticky priradit
  # 4. excluded     - vynata adminom zo spracovania
  # 5. fail         - vynimocny stav, pouziva sa na oznacenie chybneho zaznamu na upozornenie spravcu
  STATES = %w{ unprocessed assigned unresolved excluded fail }

  belongs_to :mail
  has_one :expense_posting, dependent: :destroy
  has_one :user_posting, dependent: :destroy


end
