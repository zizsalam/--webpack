class OrdersController < ApplicationController
  def create
    # Assuming you get teddy_id from params or another source
    teddy = Teddy.find(params[:teddy_id])

    # Create a Price object in Stripe
    price = Stripe::Price.create({
      unit_amount: teddy.price_cents,
      currency: 'eur',
      product_data: {
        name: teddy.sku,
        images: [teddy.photo_url],
      },
    })

    # Create the order and reference the created Price object in line_items
    order = Order.create!(teddy: teddy, teddy_sku: teddy.sku, amount: teddy.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: price.id,
        quantity: 1,
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
