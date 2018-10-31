class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :user_id
  validates :price, presence: true, :numericality => { greater_than: 0}
  validates :inventory, presence: true, :numericality => { greater_than_or_equal_to: 0}

  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user

end
