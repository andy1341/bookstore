FactoryGirl.define do
  factory :book do
    title {FFaker::Movie.title}
    short_description {FFaker::Lorem.paragraph}
    description {FFaker::Lorem.paragraphs}
    author
    category
    price {50+rand(1000)}
  end
end
