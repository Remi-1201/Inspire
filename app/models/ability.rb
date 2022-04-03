class Ability
  include CanCan::Ability

  def initialize(user)    
    user ||= User.new  
      if user.try(:admin?)
        can :access, :rails_admin
        can :manage, :all
      else
        can :read, Blog
        can :create, User
    end 
  end  
end
