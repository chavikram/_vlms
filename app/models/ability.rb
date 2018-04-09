class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    
    else
      can :read, :all
      
      can :manage, VipReference
      can :manage , Feedback
      can :manage, Section
    end
  end
end
