require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'fields' do
    it {is_expected.to validate_presence_of(:firstname)}
    it {is_expected.to validate_presence_of(:lastname)}
    it {is_expected.to validate_presence_of(:street_address)}
    it {is_expected.to validate_presence_of(:city)}
    it {is_expected.to validate_presence_of(:phone)}
    it {is_expected.to belong_to(:country)}
  end
end
