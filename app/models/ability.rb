class Ability
  include CanCan::Ability

  def initialize(user)
    
    #user ||= User.new # guest user

    if user.super_admin?
      can :manage, :all
    else
      can :read, :home
      can :index, ParticipationPosting

      can :read, Expense
      can [:create, :update], Expense do |expense|
        user.admin?
      end
      #can :participate, Expense do |expense|
      #  (not expense.locked?) or user.admin?
      #end

    end

  end

end