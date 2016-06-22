# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'json'
require 'csv'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless AdminUser.exists?(email:'admin@example.com')

response = Net::HTTP.get(URI('http://country.io/names.json'))
countries = JSON.parse(response)

countries.each do |code,country|
  Country.create!(title:country) unless Country.exists?(title:country)
end

CSV.read(File.expand_path 'db/seeds/categories.csv').each do |category|
  Category.create(name:category[0])
end

CSV.read(File.expand_path 'db/seeds/authors.csv').each do |author|
  Author.create(firstname: author[0],lastname: author[1], description: author[2])
end

CSV.read(File.expand_path 'db/seeds/books.csv').each do |book|
  Book.create(title:book[0], short_description: book[1], description: book[2], price: rand(1000), category_id:8, author_id:8)
end

Delivery.create(name:'Singapore Post', cost: 5)
Delivery.create(name:'EMS', cost: 10)
Delivery.create(name:'China Post Registered Air Mail', cost: 15)