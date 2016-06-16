# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'json'

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless AdminUser.exists?(email:'admin@example.com')

response = Net::HTTP.get(URI('http://country.io/names.json'))
countries = JSON.parse(response)

countries.each do |code,country|
  Country.create!(title:country) unless Country.exists?(title:country)
end