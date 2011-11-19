class Email < ActiveRecord::Base
  has_many :transactions
end
