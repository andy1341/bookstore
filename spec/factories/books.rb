FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "#{FFaker::Movie.title}#{n}" }
    short_description { FFaker::Lorem.paragraph }
    description { FFaker::Lorem.paragraphs }
    author
    category
    price { 50 + rand(1000) }

    factory :ordered_book do
      transient do
        count 1
      end

      after(:create) do |book, evaluator|
        create(:orders_item, book: book, count: evaluator.count)
      end
    end
  end
end
