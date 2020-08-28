class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')
    new_announce_quantity = order.announce.quantity - order.quantity
    order.announce.update_attribute(:quantity, new_announce_quantity)
    order.announce.update_attribute(active: false) if order.announce.quantity.zero?
  end
end