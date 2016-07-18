require 'rails_helper'

shared_examples_for 'facebookable' do
  let(:model) { build(described_class.to_s.underscore.to_sym) }
  let(:bool_values) { [true, false] }
  let(:provider) { 'facebook' }
  let(:uid) { '1234567890' }
  let(:info) { { email: 'andy1341@qip.ru' } }

  describe '#is_facebook_account' do
    it 'return bolean value' do
      expect(model.is_facebook_account).to be_in bool_values
    end
  end

  describe '#check_facebook' do
    it 'return bolean value' do
      expect(model.check_facebook(provider, uid)).to be_in bool_values
    end
  end

  describe '#save_facebook_data' do
    let(:data) { { provider: provider, uid: uid } }
    it "return false if facebook data doesn't match" do
      allow(model).to receive(:is_facebook_account).and_return(true)
      allow(model).to receive(:check_facebook).and_return(false)
      expect(model.save_facebook_data(data)).to eq false
    end
    it 'return true if this is current facebook user' do
      allow(model).to receive(:check_facebook).and_return(true)
      expect(model.save_facebook_data(data)).to eq true
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(provider: provider, uid: uid, info: info)
    end

    context 'user with email exist' do
      it 'if user has another uid return nil' do
        allow(described_class).to receive(:find_by_email).and_return(model)
        allow(model).to receive(:save_facebook_data).and_return(false)
        expect(described_class.from_omniauth(auth)).to eq nil
      end
    end

    it 'return User' do
      expect(described_class.from_omniauth(auth)).to be_a described_class
    end
  end
end
