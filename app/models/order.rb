class Order < ApplicationRecord
  belongs_to :announce
  belongs_to :user
  monetize :price_cents

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
