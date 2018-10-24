require 'rails_helper'

describe OrderItem, type: :model do
  describe 'Relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
    # it {should belong_to(:user)} user is purchaser
  end
end
