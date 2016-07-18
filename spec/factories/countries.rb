FactoryGirl.define do
  factory :country do
    sequence(:title) { |n| "#{FFaker::Address.country} #{n}" }
  end
end
