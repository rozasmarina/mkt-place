class Order < ApplicationRecord
  belongs_to :announce
  belongs_to :user
  monetize :price_cents
  monetize :quantity_cents

  validates :price_cents, :quantity, presence: true
  validates :price_cents, :quantity, numericality: true
  validates :price_cents, :quantity, numericality: { greater_than: 0 }
end
