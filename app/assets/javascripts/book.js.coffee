window.Book =
  onAddReview: (e, data, status, xhr) ->
    target = e.currentTarget
    data = data.responseJSON
    Helper.hideErrors()
    if data.errors
      Helper.showErrors(data.errors)
    else
      $('.new-review').html(data.message);