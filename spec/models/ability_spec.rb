require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  let(:user) { create(:admin_user) }

  context 'user' do
    subject(:ability) { Ability.new(user) }
    it {is_expected.to be_able_to :show, Order, user:user}
    it {is_expected.to be_able_to :update, Order, user:user}
    it {is_expected.to be_able_to :index, Order, user:user}
    it {is_expected.to be_able_to :make_order, Order, user:user}
    it {is_expected.to be_able_to :show, User, id: user.id}
    it {is_expected.to be_able_to :create, Review}
  end

  context 'not log in' do
    subject(:ability) { Ability.new(nil) }
    it {is_expected.to be_able_to :manage, OrdersItem}
    it {is_expected.to be_able_to :index, Category}
    it {is_expected.to be_able_to :show, Category}
    it {is_expected.to be_able_to :show, Book}
    it {is_expected.to be_able_to :apply, Coupon}
    it {is_expected.not_to be_able_to :show, Order}
    it {is_expected.not_to be_able_to :update, Order}
    it {is_expected.not_to be_able_to :index, Order}
    it {is_expected.not_to be_able_to :make_order, Order}
    it {is_expected.not_to be_able_to :show, User}
    it {is_expected.not_to be_able_to :create, Review}
  end
end
