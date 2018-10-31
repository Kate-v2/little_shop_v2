class OrderItem < ApplicationRecord
  validates_presence_of :order,
                        :item,
                        :quantity,
                        :purchase_price
                        :status
  belongs_to :item
  belongs_to :order
  #merchant purchaser issue
  # belongs_to :user, through: :item

  enum status: %w(pending complete canceled)

  def self.with_subtotals
    select('order_items.*, (quantity * purchase_price) AS subtotal')
  end


end
