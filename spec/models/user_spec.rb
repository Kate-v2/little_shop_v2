require 'rails_helper'

describe User, type: :model do
  describe 'Relationships' do
    it {should have_many(:items)}
    it {should have_many(:order_items)}
    it {should have_many(:orders)}
  end

  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password_digest)}
  end
end
