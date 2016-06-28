ActiveAdmin.register Review do
  permit_params :status

  index do
    selectable_column
    id_column
    column :text
    column :rating
    column :book do |review|
      review.reviewable.title
    end
    column :user do |review|
      review.user.email
    end
    column :status
    actions
  end

  form do |f|
    f.inputs "Review" do
      f.input :status
    end
    f.actions
  end
end
