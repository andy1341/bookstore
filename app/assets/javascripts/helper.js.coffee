window.Helper =
  showError: (message, field) ->
    selector =
      if field
        ".text-danger." + field
      else
        'h1'
    $(selector).html(message)
  showErrors: (errors) ->
    for field, message of errors
      this.showError(message[0], field)