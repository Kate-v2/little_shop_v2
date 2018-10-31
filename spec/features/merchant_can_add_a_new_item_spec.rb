require 'rails_helper'

describe 'merchant can create an item' do

  it 'through an merchant' do
    user = create(:user, role: "merchant")
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Log In'

    visit dashboard_items_new_path


    fill_in "Item Name", with: 'Kickball'
    fill_in "Price", with: 100
    fill_in "Description", with: 'fun'
    fill_in "Inventory", with: 200

    click_on "Create Item"

    expect(page).to have_content("Kickball added to store")
    expect(current_path).to have_content(dashboard_items_path)
  end

end
