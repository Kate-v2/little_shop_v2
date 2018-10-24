class User < ApplicationRecord
  has_many :orders
  has_many :order_items, through: :orders
  #below is for merchants only
  has_many :items
end
