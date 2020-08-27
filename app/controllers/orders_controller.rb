class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    redirect_to root_path unless @order.announce.user == current_user || @order.user == current_user
  end

  def new
    @announce = Announce.find(params[:announce_id])
    @order = Order.new
  end

  def create
    announce = Announce.find(params[:announce_id])
    order = Order.create!(
                announce: announce,
                user: current_user,
                state: 'pending',
                quantity: order_params['quantity'],
                price: announce.price
                )

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: order.announce.product_name,
        # images: [@announce.photo_url],
        amount: order.price_cents, # always provide price with cents, otherwise the ammount will not work
        currency: 'usd',
        quantity: order.quantity
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)

    # if @order.save
    #   @announce.quantity -= @order.quantity
    #   @announce.update_attribute(:quantity, @announce.quantity)
    #   redirect_to announce_path(@announce)
    # else
    #   render :new
    # end
  end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end

  def owner_check
    redirect_to announces_path unless @order.user == current_user
  end
end
