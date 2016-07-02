require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'fields' do
    it {is_expected.to have_many :books}
    it {is_expected.to validate_presence_of :firstname}
    it {is_expected.to validate_presence_of :lastname}
    it do
      FactoryGirl.create(:author)
      is_expected.to validate_uniqueness_of(:firstname).scoped_to(:lastname)
    end
  end
end
