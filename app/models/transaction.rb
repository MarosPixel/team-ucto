class Transaction < ActiveRecord::Base

  ##    STAVY transakcii
  # 1. unprocessed  - nespracovavana, caka na automaticke priradenie
  # 2. assigned     - uspesne priradena pouzivatelovi
  # 3. unresolved   - nepodarilo sa automaticky priradit
  # 4. excluded     - vynata adminom zo spracovania
  # 5. fail         - vynimocny stav, pouziva sa na oznacenie chybneho zaznamu na upozornenie spravcu
  STATES = %w{ unprocessed assigned unresolved excluded fail }

  belongs_to :email, dependent: :delete
  has_one :expense_posting, dependent: :destroy
  has_one :user_posting, dependent: :destroy


  def assign
    if variabilny_symbol.blank? or variabilny_symbol <= 0
      self.state = :unresolved
    else

      user = User.find_by_vs(variabilny_symbol)
      if user.blank?
        self.state = :unresolved
      else
        UserPosting.create(
          user_id: user.id,
          transaction_id: id,
          price: suma
        )
        self.state = :assigned
      end

    end
    save
  end

end
