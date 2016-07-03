require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'fields' do
    subject {FactoryGirl.create(:category)}
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_uniqueness_of :name}
    it {is_expected.to have_many :books}
  end
end
