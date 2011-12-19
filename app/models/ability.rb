class Ability
  include CanCan::Ability

  def initialize(user)
    
    #user ||= User.new # guest user

    if user.super_admin?
      can :manage, :all
    else
      can :read, :home

      #can :index, Participation
      # can [:add, :delete], Participation do |partic|
      #   (partic.try(:user) == user and not partic.try(:expense).locked?) or user.admin?
      # end

      can :read, Expense
      can [:create, :update], Expense do |expense|
        (expense.try(:creator) == user and not expense.locked?) or user.admin?
      end

    end

  end

end