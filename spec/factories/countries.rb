FactoryGirl.define do
  factory :country do
    sequence(:title) {|n| "#{FFaker::Address.country} #{n.to_s}"}
  end
end
