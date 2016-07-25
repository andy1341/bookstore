require 'rails_helper'

RSpec.describe Review, type: :model do
  subject { create(:review) }
  context 'fields' do
    it 'belong to reviable' do
      is_expected.to belong_to(:reviewable)
    end

    it 'status must be enum' do
      is_expected.to define_enum_for :status
    end
    it { is_expected.to belong_to :user }

    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :rating }
    it { is_expected.to validate_presence_of :user }
  end
end
