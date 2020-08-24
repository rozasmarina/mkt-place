class Announce < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :price, :quantity, :product_name, :product_description, :product_category, presence: true
  validates :product_description, length: { minimum: 50 }
  validates :price, :quantity, numericality: true
  validates :price, :quantity, numericality: { greater_than: 0 }
end
