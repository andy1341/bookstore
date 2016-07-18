require 'net/http'
require 'json'
require 'csv'

AdminUser.create(email: 'admin@example.com',
                 password: 'password',
                 password_confirmation: 'password')

response = Net::HTTP.get(URI('http://country.io/names.json'))
countries = JSON.parse(response)

countries.each do |_, country|
  Country.create(title: country)
end

CSV.read(File.expand_path('db/seeds/categories.csv')).each do |category|
  Category.create(name: category[0])
end

CSV.read(File.expand_path('db/seeds/authors.csv')).each do |author|
  Author.create(firstname: author[0],
                lastname: author[1],
                description: author[2])
end

CSV.read(File.expand_path('db/seeds/books.csv')).each do |book|
  Book.create(title: book[0],
              short_description: book[1],
              description: book[2],
              price: rand(1000),
              category_id: 8,
              author_id: 8)
end

Delivery.create(name: 'Singapore Post', cost: 5)
Delivery.create(name: 'EMS', cost: 10)
Delivery.create(name: 'China Post Registered Air Mail', cost: 15)

Book.update_all(image:'index.jpg')