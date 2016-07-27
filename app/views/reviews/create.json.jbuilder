if @review.errors.any?
  json.errors @review.errors
else
  json.message content_tag(:h3, t('books.success_review.message'))
end