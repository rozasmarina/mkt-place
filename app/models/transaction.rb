class Transaction < ApplicationRecord
  belongs_to :announce
  belongs_to :user

  validates :price, :quantity, presence: true
  validates :price, :quantity, numericality: true
    validates :price, :quantity, numericality: { greater_than: 0 }
end
