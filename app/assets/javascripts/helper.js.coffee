window.Helper =
  error: (message, field) ->
    selector =
      if field
        ".form-group." + field
      else
        'h1'
    $(selector).after("<span class='alert alert-danger'>"+message+"</span>")