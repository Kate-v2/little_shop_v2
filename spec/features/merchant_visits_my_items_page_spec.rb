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



end
