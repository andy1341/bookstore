FactoryGirl.define do
  factory :credit_card do
    number {FFaker.numerify('################')}
    expiration_year '20'
    expiration_month '12'
    code {FFaker.numerify('###')}
  end
end
