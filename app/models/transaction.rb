class Transaction < ActiveRecord::Base
  belongs_to :email
  has_one :bank_posting
end
