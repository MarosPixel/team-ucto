class ActionLog < ActiveRecord::Base
  belongs_to :trackable, polymorphic: true
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
end
