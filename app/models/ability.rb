class Ability
  include CanCan::Ability

  def initialize(user)
    

    can :manage, User

    user ||= User.new # guest user
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :read, :all
    else
      #can :read, :all
    end

  end

end