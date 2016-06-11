json.array!(@authors) do |author|
  json.extract! author, :id, :firstname, :lastname, :description
  json.url author_url(author, format: :json)
end
