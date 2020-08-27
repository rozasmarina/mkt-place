class Announce < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_one_attached :photo
  monetize :price_cents

  validates :price_cents, :quantity, :product_name, :product_description,
            :product_category, :announce_type, presence: true

  validates :product_description, length: { minimum: 50 }
  validates :price_cents, :quantity, numericality: true
  validates :price_cents, :quantity, numericality: { greater_than: 0 }
  validates :announce_type, inclusion: { in: %w[Gallery Top Free] }
end
