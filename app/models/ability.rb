class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Blog
    if user.present?  
      can :manage, Blog, user_id: user.id 
      if user.admin? 
        can :access, :rails_admin
        can :manage, :all
      end
    end
  end
end
