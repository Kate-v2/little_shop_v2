require 'rails_helper'

describe OrderItem, type: :model do
  describe 'Relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
    # it {should belong_to(:user)} user is purchaser
  end

  describe 'Validations' do
    it {should validate_presence_of(:order)}
    it {should validate_presence_of(:item)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:purchase_price)}
  end
end
