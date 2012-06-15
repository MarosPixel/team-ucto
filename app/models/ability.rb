class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user


    if user.super_admin?

      can :manage, :all

    else

      can :read, :home

      can :read, Expense
      can [:create, :update], Expense do
        user.admin?
      end

      can :index, ParticipationPosting
      can :participate, ParticipationPosting do |pap|
        user.admin? or ( user == pap.try(:user) and not pap.try(:expense).locked? )
      end

      can :read_your, Posting
      can :read_team, Posting do
        user.admin?
      end

    end

  end

end