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

  def find_merchant_order_ids
    #returns array of orders associated with a subset of items
    items.joins(:order_items)
    .pluck(:order_id)
  end

  enum role: %w(default merchant admin)

  has_secure_password

end
