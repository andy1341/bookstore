FactoryGirl.define do
  factory :orders_item do
    book
    count '1'
    cost {book.cost}
  end
end
