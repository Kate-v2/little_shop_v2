require 'rails_helper'
require 'feature_helper'

describe 'merchant vists their items page' do
  include FeatureHelper
  before(:each) do

    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
  end

  it 'and can click link to add new item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    expect(current_path).to eq("/dashboard/items/new")
  end

  it 'can create a new item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    page.fill_in 'Item Name', with: 'Burrito'
    page.fill_in 'Price', with: 8
    page.fill_in 'Description', with: 'Has green chile'
    page.fill_in 'Inventory', with: 20
    click_button("Create Item")

    expect(current_path).to eq("/dashboard/items")
  end




end
