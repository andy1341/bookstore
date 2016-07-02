FactoryGirl.define do
  factory :address do
    firstname {FFaker::Name.first_name}
    lastname {FFaker::Name.last_name}
    street_address {FFaker::Address.street_address}
    city {FFaker::Address.city}
    zip {FFaker::AddressUA.zip_code}
    phone{FFaker::PhoneNumber.phone_number}
    country
  end
end
