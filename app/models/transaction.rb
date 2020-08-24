class Transaction < ApplicationRecord
  belongs_to :announce
  belongs_to :user
end
