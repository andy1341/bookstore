FactoryGirl.define do
  factory :coupon do
    name {FFaker::Lorem.word}
    discount {1+rand(99)}
  end
end
