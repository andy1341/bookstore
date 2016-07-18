require 'rails_helper'

RSpec.describe OrdersItem, type: :model do
  subject { build(:orders_item) }
  context 'fields' do
    it { is_expected.to belong_to :book }
    it { is_expected.to belong_to :order }
    it { is_expected.to validate_presence_of :count }
    it { is_expected.to validate_presence_of :book }
    it { is_expected.to validate_presence_of :order }
    it { is_expected.to validate_uniqueness_of(:book).scoped_to(:order_id) }
  end

  it 'set cost before create' do
    is_expected.to receive :set_cost
    subject.save
  end
  it 'update order after save' do
    is_expected.to receive :order_update
    subject.save
  end

  describe '#total' do
    it "return 0 if cost does't set" do
      subject.cost = nil
      expect(subject.total).to eq 0
    end
  end
  describe '#order_update' do
    it 'call order save' do
      expect(subject.order).to receive :save
      subject.order_update
    end
  end
  describe '#set_cost' do
    it 'set cost to current book prive' do
      subject.set_cost
      expect(subject.cost).to eq subject.book.price
    end
  end
end
