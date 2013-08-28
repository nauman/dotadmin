class Ability
  include CanCan::Ability
  
  def initialize(user)
    can :manage, :all if user.has_role? :admin
    cannot :manage, RoleType if user.has_role? :admin
    can :manage, :all if user.has_role? :superadmin
  end
end
