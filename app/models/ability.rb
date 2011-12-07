class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user_signed_in?

      if user.super_admin?
        can :manage, :all
      elsif user.admin?
        can :read, :all
      else
        can :read, :all
      end

    else
      can :read, :new_user_session
    end
  end

end