class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :admin_panel if AdminUser.admin?(user)
    can [:show, :update, :index, :make_order], Order, user:user
  end
end
