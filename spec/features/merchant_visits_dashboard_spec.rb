require 'rails_helper'
require 'feature_helper'

describe 'merchant visits dashboard' do
  include FeatureHelper
  before(:each) do

    @merch = create(:user, role: 1)
    @user = create(:user, role: 0)
    create_list(:item, 3, user_id: @merch.id)
  end

  it 'and sees all items for that merchant' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")

    expect(current_path).to eq("/dashboard/items")
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("#{@merch.items[0].name}")
    expect(page).to have_content("#{@merch.items[1].name}")
    expect(page).to have_content("#{@merch.items[2].name}")
    expect(page).to have_content("#{@merch.items[0].id}")
    expect(page).to have_content("#{@merch.items[1].id}")
    expect(page).to have_content("#{@merch.items[2].id}")
    expect(page).to have_content("#{@merch.items[0].price}")
    expect(page).to have_content("#{@merch.items[1].price}")
    expect(page).to have_content("#{@merch.items[2].price}")
    expect(page).to have_content("#{@merch.items[0].inventory}")
    expect(page).to have_content("#{@merch.items[1].inventory}")
    expect(page).to have_content("#{@merch.items[2].inventory}")
    expect(page).to have_content("Add New Item")
    expect(page).to have_content("Edit Item")

  end

  it 'and can click link to item show page' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("#{@merch.items[1].name}")

    expect(current_path).to eq("/items/#{@merch.items[1].id}")
  end

  it 'and can click link to add new item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Add New Item")

    expect(current_path).to eq("/items/new")
  end

  it 'and can click link to edit item' do
    login(@merch)
    visit dashboard_path
    click_on("All My Items")
    click_on("Edit #{@merch.items.first.name}")

    expect(current_path).to eq("/items/#{@merch.items.first.id}/edit")
  end

  it 'normal user is denied access' do
    login(@user)
    visit dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
