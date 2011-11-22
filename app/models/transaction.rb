class Transaction < ActiveRecord::Base
  belongs_to :email
  has_one :expense_posting
  has_one :user_posting
end
