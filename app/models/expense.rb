class Expense < ActiveRecord::Base
  EXPENSE_TYPES = %w{ training tournament other_expense }

  # Associations
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one  :expense_posting, dependent: :delete
  has_many :participation_postings, dependent: :delete_all
  has_many :users, through: :participation_postings, uniq: true

  def locked?
    locked_at < Time.now
  end

  def calc_expense_posting_price
    case type
    when 'Training'
      - total_price
    when 'Tournament'
      - team_fee - (player_fee * users.count)
    when 'OtherExpense'
      if total_price.nil? or total_price == 0
        - team_fee - (player_fee * users.count)
      else
        - total_price
      end
    end
  end

end
