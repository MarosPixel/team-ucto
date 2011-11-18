class Email < ActiveRecord::Base
  has_many :transactions
  has_many :logs, class_name: 'ActionLog', as: :trackable
end
