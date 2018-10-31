require 'rails_helper'
require 'feature_helper'

describe 'From the dashboard' do
  include FeatureHelper
  before(:each) do
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    @item = @merch.items.create(name: 'Taco', price: 5,description: "yum", inventory: 100)
  end

  it 'merchant can create a new item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    fill_in "Item Name", with: 'Kickball'
    fill_in "Price", with: 100
    fill_in "Description", with: 'fun'
    fill_in "Inventory", with: 200

    click_on "Create Item"

    expect(current_path).to eq("/dashboard/items")
    expect(page).to have_content("Kickball")
    expect(page).to have_content("100")
    expect(page).to have_content("200")
  end

  it 'merchant is denied when creating a new item with ' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 0
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Create Item"

    expect(current_path).to eq("/dashboard/items/new")
  end

  it 'merchant can update item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 1
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Create Item"
    click_on "Edit Kickball"

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 5
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Update Item"

    expect(page).to have_content("Kickball")
    expect(page).to have_content("5")
  end

  it 'merchant cant update item with invalid info' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 1
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Create Item"
    click_on "Edit Kickball"

    fill_in 'Item Name', with: 'Kickball'
    fill_in 'Price', with: 0
    fill_in 'Description', with: 'fun'
    fill_in 'Inventory', with: 200

    click_on "Update Item"

    expect(page).to have_content("Edit Item")
    expect(page).to have_content("Please double check your info and try again")
  end

  it 'merchant can disable item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on ("Disable Taco")

    expect(page).to have_content("#{@item.name} no longer for sale")

    click_on ("Enable Taco")

    expect(page).to have_content("#{@item.name} is now for sale")

  end

end
