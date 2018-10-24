require 'rails_helper'

describe Item, type: :model do
  describe 'Relationships' do
    it {should have_many(:order_items)}
    it {should have_many(:orders)}
    it {should belong_to(:user)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:inventory)}
    it {should validate_presence_of(:user_id)}
  end
end
