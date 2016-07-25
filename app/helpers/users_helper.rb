module UsersHelper
  def user_form
    form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f|
      yield f
    end
  end
end