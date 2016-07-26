App =
  init: ->
    this.cart();
    this.book();
  cart: ->
    $(".add-to-cart").on("ajax:complete", (e, data, status, xhr) ->
      data = data.responseJSON;
      $(".cart-link").html(data.cart_text);
      $(".cart-btn-container#"+data.orders_item_id).html(data.btn);
    );

    $("[id^=edit_orders_item]").on("ajax:complete", (e, data, status, xhr) ->
      data = data.responseJSON;
      $("#orders_item_"+data.orders_item.id+" .total").html("$"+data.orders_item.total);
      $(".cart-content .cart-total").html("$"+data.order.subtotal);
    );

    $('.orders_item a[data-method=delete]').on("ajax:complete", (e, data, status, xhr) ->
      data = data.responseJSON
      $(".cart-link").html(data.cart_text);
      $(".cart-content .cart-total").html("$"+data.order.subtotal);

      if data.cart_content
        $(".cart-content").html("<h2>"+data.cart_content+"</h2>")
      else
        $("#orders_item_"+data.orders_item_id).remove()
    )
  book: ->
    $('#new_review').on("ajax:complete", (e, data, status, xhr) ->
      target = e.currentTarget
      data = data.responseJSON
      if data.errors
        for field, error of data.errors
          App.Helpers.error(field,error)
      else
        $('.new-review').html(data.message);
    )
  Helpers:
    error: (field, error)->
      $(".form-group."+field).after("<span class='alert alert-danger'>"+error+"</span>")


$(document).ready ->
  App.init();