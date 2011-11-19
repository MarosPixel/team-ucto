class Event < ActiveRecord::Base
  EVENT_TYPES = %w{ training tournament without_date }

  # Associations
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one  :event_posting
  has_many :participation_postings
  has_many :users, through: :participation_postings

end
