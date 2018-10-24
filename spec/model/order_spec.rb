require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it {should have_many(:items)}
    it {should have_many(:order_items)}
    it {should belong_to(:user)}
    #alias column customer_id and merchant_id
  end

  describe 'Validations' do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:user_id)}
  end
end
