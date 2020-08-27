require 'open-uri'
class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :set_default_avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :announces
  has_many :orders
  has_one_attached :photo
  validates :first_name, :last_name, :address, :phone_number, :username, :email, :cpf, presence: { message: "Campo obrigatório" }
  validates :username, :email, :cpf, uniqueness: true
  validates :email, confirmation: true
  validates :first_name, :last_name,
            format: { with: /[A-Za-z]+/,
                      message: "Permitido somente caracteres alfanuméricos" }
  validates :cpf,
            format: { with: /\A\d{3}\.?\d{3}\.?\d{3}-?\d{2}\z/,
                      message: "Entre um CPF válido" }
  validates :phone_number,
            format: { with: /\A(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))\z/,
                      message: "Entre um telefone válido" }
  validates :email,
            format: { with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/,
                      message: "Entre um e-mail válido" }
  validates :username,
            format: { with: /\A(?=[a-zA-Z0-9._-]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]\z/,
                      message: "Deve ter entre 8 e 20 caracateres" }

  def set_default_avatar
    unless photo.attached?
      avatar_url = "https://api.adorable.io/avatars/150/edcolen@adorable.png"
      avatar = URI.open(avatar_url)
      photo.attach(io: avatar, filename: 'avatar.png', content_type: 'image/png')
    end
  end
end
