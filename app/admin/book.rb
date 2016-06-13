ActiveAdmin.register Book do
  permit_params :title, :short_description, :desctiption, :price, :image

  index do
    selectable_column
    id_column
    column :title
    column :short_description
    column :description
    column :author
    column :category
    column :price
    column :image do |book|
      image_tag book.image, width: '100px'
    end
    actions
  end

  filter :title
  filter :author
  filter :category
  filter :price

  form do |f|
    f.inputs "Book Details" do
      f.input :title
      f.input :short_description
      f.input :description
      f.input :author
      f.input :category
      f.input :price
      f.input :image, hint:image_tag(f.object.image, width: '200px')
    end
    f.actions
  end
end
