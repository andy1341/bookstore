require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create(:category_with_book) }
  let(:empty_category) { FactoryGirl.create(:category) }

  context 'fields' do
    subject { category }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to have_many :books }
  end

  context 'scopes' do
    describe '.with_books' do
      subject { Category.with_books }
      it 'return category with books' do
        is_expected.to include(category)
      end

      it "doesn't return empty category" do
        is_expected.not_to include(empty_category)
      end
    end
  end
end
