class AddPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_monetize :orders, :price, currency: { present: false } 
  end
end
