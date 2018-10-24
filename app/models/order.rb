class Order < ApplicationRecord
  validates_presence_of :status,
                        :user_id
  has_many :order_items
  has_many :items, through: :order_items
  #just for the customer
  belongs_to :user
end
