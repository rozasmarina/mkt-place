class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :announces
  has_many :transactions
  validates :first_name, :last_name, :address, :phone, :username, :email, :cpf, presence: true
  validates :username, :email, :cpf, uniqueness: true
end
