ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs 'Order Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
