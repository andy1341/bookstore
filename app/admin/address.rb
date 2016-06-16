ActiveAdmin.register Address do
  permit_params :firstname, :lastname, :country_id,
     :address_type_id, :user_id, :street_address,
     :city, :zip, :phone
end
