require 'rails_helper'

describe 'merchant can create an item' do

  xit 'through an merchant' do

    user = create(:user)
    name = "kickball"

    visit new_user_item_path(user)

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 100
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Create Item"

  end

end
