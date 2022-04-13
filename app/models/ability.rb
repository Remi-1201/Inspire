class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    can :read, Blog
    if user.present?  
      can :manage, Blog, user_id: user.id 
      if user.admin? 
        can :manage, :all
      end
    end
  end
end
