class Item < ApplicationRecord
  validates_presence_of :name,
                        :price,
                        :description,
                        :inventory,
                        :user_id

  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user

end
