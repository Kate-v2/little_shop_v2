require 'rails_helper'

describe Item, type: :model do
  describe 'Relationships' do
    it {should have_many(:order_items)}
    it {should have_many(:orders)}
    it {should belong_to(:user)}
  end
end
