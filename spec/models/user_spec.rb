require 'rails_helper'
require 'models/concerns/facebookable_spec'

RSpec.describe User, type: :model do
  subject { build(:user) }
  context 'fields' do
    it do
      is_expected.to belong_to(:billing_address)
        .class_name(Address)
        .dependent(:destroy)
    end
    it do
      is_expected.to belong_to(:shipping_address)
        .class_name(Address)
        .dependent(:destroy)
    end
    it { is_expected.to belong_to(:credit_card).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for :billing_address }
    it { is_expected.to accept_nested_attributes_for :shipping_address }
    it { is_expected.to accept_nested_attributes_for :credit_card }
  end

  it_behaves_like 'facebookable'

  describe '#order_in_progress' do
    it 'return last in progress order' do
      order = create(:order, user: subject)
      expect(subject.order_in_progress).to eq order
    end
  end
end
