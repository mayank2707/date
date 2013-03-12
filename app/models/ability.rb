class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
   if user && user.role?(:admin)
      can :manage, :all
    else
    can :read, :all 
  end
  
  if user.role? :user
    can :manage, Profile
  end
  
  if user.role? :admin
    can :manage, Profile
  end
  
end
end