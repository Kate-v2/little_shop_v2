require 'rails_helper'
require 'feature_helper'

describe 'Admin can' do
  include FeatureHelper
  before(:each) do
    @merch = create(:user, role: 1)
    @user = create(:user, role: 0)
    @user2 = create(:user, role: 0)
    @admin = create(:user, role: 2)
    create_list(:item, 3, user_id: @merch.id)
    @item = @merch.items.create(name: 'Taco', price: 5,description: "yum", inventory: 100)
  end

  it 'update another user' do
    login(@user)
    visit user_path(@user2)

    expect(page).to have_content("404")
  end

end
