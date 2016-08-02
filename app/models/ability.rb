class Ability
  include CanCan::Ability

  def initialize(user)
    can [:manage], OrdersItem
    can [:index, :show], Category
    can [:show], Book
    can [:apply], Coupon
    if user.present?
      can [:show, :update, :index, :make_order], Order, user:user
      can [:show], User, id: user.id
      can [:create], Review
    end
  end
end
