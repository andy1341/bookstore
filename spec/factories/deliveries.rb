FactoryGirl.define do
  factory :delivery do
    name { FFaker::Company.name }
    cost '10'
  end
end
