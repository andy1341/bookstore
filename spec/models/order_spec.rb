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
  end

  it { is_expected.to delegate_method(:empty?).to(:orders_items) }
  it 'set total before save' do
    expect(subject).to receive(:set_total)
    subject.save
  end

  let(:order) { FactoryGirl.create(:order) }

  describe '#can_make_order?' do
    after { expect(order.can_make_order?).to eq false }

    [:user,
     :billing_address,
     :shipping_address,
     :delivery,
     :credit_card].each do |field|
      it "return false if #{field} blank" do
        order.send("#{field}=", nil)
      end
    end

    it 'return false if order items empty' do
      order.orders_items = []
    end
  end

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
