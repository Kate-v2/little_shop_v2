class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  #merchant purchaser issue
  # belongs_to :user, through: :item
end
