require 'rails_helper'
require 'feature_helper'

describe 'As an admin' do

  include FeatureHelper
  before(:each) do
    @admin = create(:user, role: 2)
    @merch = create(:user, role: 1)
    create_list(:user, 6)
    create_list(:item, 3, user_id: @merch.id)
    @item = @merch.items.create(name: 'Taco', price: 5,description: "yum", inventory: 100)
    login(@admin)
  end

  it 'can see all users' do
    visit users_path

    expect(page).to have_content(@merch.name)
  end

end
