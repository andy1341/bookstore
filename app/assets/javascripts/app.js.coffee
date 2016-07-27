window.App =
  init: ->
    $(".add-to-cart").on("ajax:complete", Cart.onAddToCart);
    $("[id^=edit_orders_item]").on("ajax:complete", Cart.onOrderItemUpdate);
    $('.orders_item a[data-method=delete]').on("ajax:complete", Cart.onOrderItemDelete);
    $('#new_review').on("ajax:complete", Book.onAddReview)
    Checkout.init()

$(document).ready ->
  App.init();