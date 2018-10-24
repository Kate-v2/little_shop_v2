class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  #just for the customer
  belongs_to :user
end
