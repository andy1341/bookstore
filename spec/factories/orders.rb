FactoryGirl.define do
  factory :order do
    user
    association :billing_address, factory: :address
    association :shipping_address, factory: :address
    delivery
    credit_card

    after(:create) do |order, _evaluator|
      order.orders_items << FactoryGirl.create(:orders_item, order: order)
    end
  end
end
