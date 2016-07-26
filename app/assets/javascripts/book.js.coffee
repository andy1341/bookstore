window.Book =
  onAddReview: (e, data, status, xhr) ->
    target = e.currentTarget
    data = data.responseJSON
    if data.errors
      for field, message of data.errors
        Helper.error(message, field)
    else
      $('.new-review').html(data.message);