require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    FactoryGirl.create(:book)
  end
  context 'fields' do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_uniqueness_of :title}
    it {is_expected.to validate_presence_of :price}
    it {is_expected.to validate_presence_of :category}
    it {is_expected.to validate_presence_of :author}
    it {is_expected.to belong_to :author}
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many :reviews}
  end
end
