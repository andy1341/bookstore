require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'fields' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :billing_address }
    it { is_expected.to belong_to :shipping_address }
    it { is_expected.to belong_to :delivery }
    it { is_expected.to belong_to :credit_card }
    it { is_expected.to belong_to :coupon }
    it { is_expected.to have_many(:orders_items).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for :billing_address }
    it { is_expected.to accept_nested_attributes_for :shipping_address }
    it { is_expected.to accept_nested_attributes_for :credit_card }
    it { is_expected.to define_enum_for :status }
    context 'order in_progress' do
      it { is_expected.not_to validate_presence_of(:user)}
      it { is_expected.not_to validate_presence_of(:billing_address_id)}
      it { is_expected.not_to validate_presence_of(:delivery)}
      it { is_expected.not_to validate_presence_of(:credit_card_id)}
      it { is_expected.not_to validate_presence_of(:orders_items)}
      it { is_expected.not_to validate_presence_of(:shipping_address_id)}
    end
    context 'order not in_progress' do
      subject do
        order = create(:order)
        order.make_order!
        order
      end
      it { is_expected.to validate_presence_of(:user)}
      it { is_expected.to validate_presence_of(:billing_address_id)}
      it { is_expected.to validate_presence_of(:delivery)}
      it { is_expected.to validate_presence_of(:credit_card_id)}
      it { is_expected.to validate_presence_of(:orders_items)}
      it { is_expected.to validate_presence_of(:shipping_address_id)}
    end
  end

  it { is_expected.to delegate_method(:empty?).to(:orders_items) }
  it 'set total before save' do
    expect(subject).to receive(:set_total)
    subject.save
  end

  let(:order) { FactoryGirl.create(:order) }

  describe '#set_total' do
    it 'call total' do
      expect(order).to receive(:total)
      order.set_total
    end
  end

  describe '#subtotal' do
    it 'return numeric' do
      expect(order.subtotal).to be_a Numeric
    end
  end

  describe '#total' do
    it 'return numeric' do
      expect(order.total).to be_a Numeric
    end
  end

  describe '#union_with' do
    let(:another) { create(:order) }
    before { order.union_with(another) }
    it 'destroy other order' do
      expect(another).to be_destroyed
    end
    it 'move order items from other' do
      expect(order.orders_items).to include(*another.orders_items)
    end
  end

  describe '#contains' do
    let(:book) { create(:book) }
    it 'return true if book in order' do
      expect(order.contains(book)).to eq false
    end
    it 'return false if book not in order' do
      book = order.orders_items.first.book
      expect(order.contains(book)).to eq true
    end
  end

  describe '#discount' do
    let(:coupon) { create(:coupon) }
    it 'return default coefficent if coupon nil' do
      expect(order.discount).to eq Order::DEFAULT_DISCOUNT_COEFFICIENT
    end
    it 'return coupon discont' do
      allow(order).to receive(:coupon) { coupon }
      expect(order.discount).to eq coupon.discount_coefficient
    end
  end
end
