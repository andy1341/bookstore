FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }

    factory :category_with_book do
      after(:create) do |category|
        create(:book, category: category)
      end
    end
  end
end
