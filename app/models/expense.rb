class Expense < ActiveRecord::Base
  EXPENSE_TYPES = %w{ training tournament other_expense }

  # Associations
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one  :expense_posting
  has_many :participation_postings
  has_many :users, through: :participation_postings, uniq: true

end
