class Ability
  include CanCan::Ability

  def initialize(user)
    if AdminUser.is_admin(user)
      can :access, :admin_panel
    end
  end
end
