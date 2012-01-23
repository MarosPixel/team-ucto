class Ability
  include CanCan::Ability

  def initialize(user)
    
    #user ||= User.new # guest user

    if user.super_admin?
      can :manage, :all
    else
      can :read, :home

      can :index, ParticipationPosting
      can :change, ParticipationPosting do |partic|
        (partic.try(:user) == user and not partic.try(:expense).locked?) or user.admin?
      end

      can :read, Expense
      can [:create, :update], Expense do |expense|
        user.admin?
      end

    end

  end

end