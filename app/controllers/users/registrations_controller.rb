class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    return resource.update_with_password(params) if params[:password]
    resource.update_without_password(params)
  end
end
