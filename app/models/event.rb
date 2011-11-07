class Event < ActiveRecord::Base
  EVENT_TYPES = %w{ training tournament without_date }

  # Relationships
  belongs_to :user
  has_one :event_bank_posting
  has_one :event_cash_posting
  has_many :participation_postings
  has_many :users, through: :participation_posting

  # Validations
  validate :event_type, inclusion: EVENT_TYPES

end
