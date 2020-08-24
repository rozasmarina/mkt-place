class Transaction < ApplicationRecord
  belongs_to :announce
  belongs_to :user
  validates :price, :quantity, presence: true
end
