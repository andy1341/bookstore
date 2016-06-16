ActiveAdmin.register User do

  permit_params :email, :billing_address_id, :shipping_address_id

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :billing_address
      f.input :shipping_address
    end
    f.actions
  end
end
