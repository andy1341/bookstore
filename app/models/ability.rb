class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :admin_panel if AdminUser.admin?(user)
    can :show, Order, user:user
    can :update, Order, user:user
    can :index, Order, user:user
    can :make_order, Order, user:user
  end
end
