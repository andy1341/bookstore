json.array!(@books) do |book|
  json.extract! book, :id, :title, :short_description, :description, :author_id, :category_id, :price, :images
  json.url book_url(book, format: :json)
end
