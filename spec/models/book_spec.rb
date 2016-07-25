require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'fields' do
    before { FactoryGirl.create(:book) }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of :title }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :author }
    it { is_expected.to belong_to :author }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many :reviews }
    it { is_expected.to have_many :orders_items }
  end

  describe '.popular_books' do
    let(:book) { create(:ordered_book) }
    let(:book1) { create(:ordered_book) }

    it 'return ordered books' do
      expect(Book.popular_books).to include(book, book1)
    end
  end
end
