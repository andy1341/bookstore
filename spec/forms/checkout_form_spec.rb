require 'rails_helper'

RSpec.describe CheckoutForm do
  it {is_expected.to delegate_method(:use_billing_address).to(:order)}
  it {is_expected.to delegate_method(:delivery_id).to(:order)}
  it {is_expected.to delegate_method(:delivery).to(:order)}
  it {is_expected.to delegate_method(:errors).to(:order)}

  describe '#save' do
    context 'step params method exist' do
      it 'update order' do
        allow(subject).to receive(:step) {:address}
        is_expected.to receive_message_chain(:order, :update)
        subject.save
      end
    end
  end

  [:billing_address, :shipping_address, :credit_card].each do |method|
    method_name = method.to_s.humanize
    describe "##{method}" do
      let(:order) {create(:order)}
      before { allow(subject).to receive(:order) {order} }

      context "order has #{method_name}" do
        it 'return order field' do
          expect(subject.send(method)).to eq(order.send(method))
        end
      end
      context "order hasn't #{method_name}" do
        it "return copy of user #{method_name}" do
          allow(order).to receive("#{method}_id") {nil}
          is_expected.to receive_message_chain(:order, :user, method, :dup)
          subject.send(method)
        end
      end
    end
  end

  describe '#step' do
    it 'return symbol' do
      subject.step = 'address'
      expect(subject.step).to be_a Symbol
    end
  end

  describe '#use_billing_address?' do
    it 'return boolean' do
      expect(subject.use_billing_address?).to be_falsey
    end
  end

  describe '#address_params' do
    it 'return hash' do
      expect(subject.address_params).to be_a Hash
    end

    it 'contains billing_address attributes' do
      expect(subject.address_params.keys).to include :billing_address_attributes
    end

    it 'contains use billing address' do
      expect(subject.address_params.keys).to include :use_billing_address
    end

    context 'use billing address' do
      it "doesn't contains shipping address" do
        allow(subject).to receive(:use_billing_address?) {true}
        expect(subject.address_params.keys).not_to include :shipping_address_attributes
      end
    end

    context "dont't use billing address" do
      it 'contains shipping address' do
        expect(subject.address_params.keys).to include :shipping_address_attributes
      end
    end
  end

  describe '#delivery_params' do
    it 'return hash' do
      expect(subject.delivery_params).to be_a Hash
    end

    it 'contains delivery_id' do
      expect(subject.delivery_params.keys).to include :delivery_id
    end
  end

  describe '#payment_params' do
    it 'return hash' do
      expect(subject.payment_params).to be_a Hash
    end

    it 'contains credit_card_attributes' do
      expect(subject.payment_params.keys).to include :credit_card_attributes
    end
  end
end