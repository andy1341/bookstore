FactoryGirl.define do
  factory :country do
    title {FFaker::Address.country}
  end
end
