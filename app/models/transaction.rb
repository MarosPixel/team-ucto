class Transaction < ActiveRecord::Base
  belongs_to :email
  has_one :event_posting
  has_one :user_posting
end