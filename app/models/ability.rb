class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :admin_panel if AdminUser.admin?(user)
  end
end
