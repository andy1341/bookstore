require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'fields' do
    it { is_expected.to validate_presence_of(:firstname) }
    it { is_expected.to validate_presence_of(:lastname) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to belong_to(:country) }
    it {is_expected.to allow_value('12345').for(:zip)}
    it {is_expected.not_to allow_value('3451233232').for(:zip)}
    it {is_expected.not_to allow_value('1').for(:zip)}
    it {is_expected.to allow_value('+380956565656').for(:phone)}
    it {is_expected.to allow_value('380956565656').for(:phone)}
    it {is_expected.to allow_value('0956565656').for(:phone)}
    it {is_expected.not_to allow_value('65656').for(:phone)}
    it {is_expected.not_to allow_value('sad').for(:phone)}
    it {is_expected.not_to allow_value('123123123123123123').for(:phone)}
  end
end
