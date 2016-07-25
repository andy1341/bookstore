require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  context 'fields' do
    it { is_expected.to validate_presence_of :number }
    it { is_expected.to validate_presence_of :expiration_month }
    it { is_expected.to validate_presence_of :expiration_year }
    it { is_expected.to validate_presence_of :code }
    it { is_expected.to allow_value('1234123412341234').for(:number) }
    it { is_expected.not_to allow_value('1234').for(:number) }
  end

  let(:is_int) { proc { |y| y.is_a? Integer } }

  describe '.years' do
    it 'return array of integers' do
      all = CreditCard.years.all?(&is_int)
      expect(all).to eq true
    end
    it 'return years from now' do
      now = Time.now.strftime('%y').to_i
      expect(CreditCard.years.min).to eq now
    end
  end

  describe '.month' do
    it 'return array of integers' do
      all = CreditCard.months.all?(&is_int)
      expect(all).to eq true
    end
    it 'return number of month' do
      expect(CreditCard.months).to eq (1..12).to_a
    end
  end
end
