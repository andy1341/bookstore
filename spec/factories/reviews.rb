FactoryGirl.define do
  factory :review do
    text {FFaker::Lorem.paragraph}
    rating '3'
    association :reviewable, factory: :book
    user
  end
end
