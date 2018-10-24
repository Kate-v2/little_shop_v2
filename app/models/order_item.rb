class OrderItem < ApplicationRecord
  validates_presence_of :order,
                        :item,
                        :quantity,
                        :purchase_price
  belongs_to :item
  belongs_to :order
  #merchant purchaser issue
  # belongs_to :user, through: :item
end
