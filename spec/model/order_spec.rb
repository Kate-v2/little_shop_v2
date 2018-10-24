require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it {should have_many(:items)}
    it {should have_many(:order_items)}
    it {should belong_to(:user)}
    #alias column customer_id and merchant_id
  end
end
