require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'fields' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it do
      is_expected.to validate_inclusion_of(:discount).in_array((1..100).to_a)
    end
  end
end
