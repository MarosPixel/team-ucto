class Transaction < ActiveRecord::Base
  belongs_to :email
  has_one :event_posting
  has_one :user_posting
  has_many :logs, class_name: 'ActionLog', as: :trackable
end
