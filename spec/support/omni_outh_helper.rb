module OmniAuthHelper
  def configure_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '123545',
        info: {
            name: FFaker::Address.name,
            email: FFaker::Internet.email
        }
    })
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end
end

RSpec.configure do |config|
  config.include OmniAuthHelper, :type => :controller
end