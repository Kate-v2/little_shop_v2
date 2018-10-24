class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  #just for the merchant
  belongs_to :user
end
