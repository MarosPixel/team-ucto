class User < ActiveRecord::Base
  ROLES = %w{ member admin super_admin }

  # Relationships
  has_many :member_bank_postings
  has_many :member_cash_postings
  has_many :participation_postings
  has_many :events, through: :participation_posting
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  has_many :created_postings, class_name: 'CashPosting', foreign_key: :creator_id
  devise :database_authenticatable, :recoverable, :registerable, 
         :rememberable, :trackable, :lockable, :validatable # definovat vlastnu validaciu

  # Setup accessible (or protected) attributes for your model
  attr_accessible :vs, :name, :email, :password, :password_confirmation, :remember_me

  # Validations
  validate :role, inclusion: ROLES

end
