window.Checkout =
  init: ->
    @onUseBillingAddress()
    $('#checkout_form_use_billing_address').click(@onUseBillingAddress)
    $('.tab-link').click(-> $('[href="#'+$(this).attr('id')+'"]').tab('show'))
    $('.checkout_form')
      .off("ajax:complete")
      .on("ajax:complete", @onCheckoutUpdate.bind(this))

  onCheckoutUpdate: (e, data, status, xhr) ->
    data = data.responseJSON
    Helper.hideErrors();
    return Helper.showErrors(data.errors) if data.errors
    document.location = data.location if data.location
    $('.order-summary').html(data.summary) if data.summary
    $('.tab-content #confirm').html(data.confirm) if data.confirm
    @nextStep()

  nextStep: ->
    $('.checkout .nav-tabs li')
      .filter('.active')
      .next('li')
      .removeClass('disabled')
      .find('a[data-toggle="tab"]')
      .tab('show');
    @init()

  onUseBillingAddress: (e) ->
    disabled =$('#checkout_form_use_billing_address').prop('checked')
    $('.shipping-address').find('input').prop('disabled', disabled)
