class Posting < ActiveRecord::Base
  has_many :logs, class_name: 'ActionLog', as: :trackable
end
