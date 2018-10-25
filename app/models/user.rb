class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :city,
                        :name,
                        :zip,
                        :address,
                        :state,
                        :password_digest, require: true


  has_many :orders
  has_many :order_items, through: :orders
  #below is for merchants only
  has_many :items


  has_secure_password
end
