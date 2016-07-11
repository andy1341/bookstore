require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  let(:user) { create(:admin_user) }
  subject(:ability) { Ability.new(user) }

  context 'admin' do
    it { is_expected.to be_able_to :access, :admin_panel}
  end
end