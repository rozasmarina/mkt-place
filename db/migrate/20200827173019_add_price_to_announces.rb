class AddPriceToAnnounces < ActiveRecord::Migration[6.0]
  def change
    add_monetize :announces, :price, currency: { present: false } 
    # currency presence false because I don't care for currency used since I'm dealing with only one
  end
end
