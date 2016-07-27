window.Cart =
  onAddToCart: (e, data, status, xhr) ->
    data = data.responseJSON;
    $(".cart-link").html(data.cart_text);
    $(".cart-btn-container#"+data.orders_item_id).html(data.btn);

  onOrderItemUpdate: (e, data, status, xhr) ->
    data = data.responseJSON;
    $("#orders_item_"+data.orders_item.id+" .total").html("$"+data.orders_item.total);
    $(".cart-content .cart-total").html("$"+data.order.subtotal);

  onOrderItemDelete: (e, data, status, xhr) ->
    data = data.responseJSON
    $(".cart-link").html(data.cart_text);
    $(".cart-content .cart-total").html("$"+data.order.subtotal);

    if data.cart_content
      $(".cart-content").html("<h2>"+data.cart_content+"</h2>")
    else
      $("#orders_item_"+data.orders_item_id).remove()