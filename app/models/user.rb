class User < ActiveRecord::Base
  ROLES = %w{ member admin super_admin }

  # Associations
  has_many :member_postings
  has_many :participation_postings
  has_many :events, through: :participation_postings
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  devise :database_authenticatable, :recoverable, :registerable, 
         :rememberable, :trackable, :validatable # definovat vlastnu validaciu

  # Setup accessible (or protected) attributes for your model
  attr_accessible :vs, :name, :email, :password, :password_confirmation, :remember_me, :approved

  # Validations
  validate :role, inclusion: ROLES

  before_create :set_vs


  public

    def active_for_authentication?
      super && approved?
    end

    def inactive_message
      if !approved?
        :not_approved
      else
        super # Use whatever other message 
      end
    end
    
    def self.send_reset_password_instructions(attributes={})
      recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
      if !recoverable.approved?
        recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
      elsif recoverable.persisted?
        recoverable.send_reset_password_instructions
      end
      recoverable
    end

  private

    def set_vs
      self.vs = 1
    end

end
