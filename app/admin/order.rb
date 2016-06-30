ActiveAdmin.register Order do
  permit_params :order, :status

  # index do
  #   selectable_column
  #   id_column
  #   column :title
  #   column :short_description
  #   column :description
  #   column :author
  #   column :category
  #   column :price
  #   column :image do |book|
  #     image_tag book.image, width: '100px'
  #   end
  #   actions
  # end

  form do |f|
    f.inputs "Order Details" do
      f.input :status
    end
    f.actions
  end
end
