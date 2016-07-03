FactoryGirl.define do
  factory :orders_item do
    book
    order
    count '1'
  end
end
