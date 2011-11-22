class User < ActiveRecord::Base
  ROLES = %w{ member admin super_admin}

  # Associations
  has_many :member_postings
  has_many :participation_postings
  has_many :events, through: :participation_postings
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  devise :database_authenticatable, :recoverable, :registerable, 
         :rememberable, :trackable, :validatable # TODO definovat vlastnu validaciu
  acts_as_audited only: [:username, :email, :is_approved, :role]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :is_approved, :role

  # Validations
  validate :role, inclusion: ROLES

  after_create :set_vs

  public

    def active_for_authentication?
      super && is_approved?
    end

    def inactive_message
      if !is_approved?
        :not_approved
      else
        super # Use whatever other message 
      end
    end
    
    def self.send_reset_password_instructions(attributes={})
      recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
      if !recoverable.is_approved?
        recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
      elsif recoverable.persisted?
        recoverable.send_reset_password_instructions
      end
      recoverable
    end

  private

    def set_vs
      self.vs = id.to_s + ("%02d" % (id % 11)).reverse
      save
    end

end
