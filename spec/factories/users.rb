FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    factory :user_with_order do
      after(:create) do |user|
        user.orders << create(:order, user: user)
      end
    end
  end
end
