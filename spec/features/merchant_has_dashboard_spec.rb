require 'rails_helper'
require 'feature_helper'

describe 'As a merchant' do
  include FeatureHelper

  before(:each) do
    # -- shop --
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    # -- purchaser --
    login(@merch)
  end

  it 'Fore anyone orders from me I dont see a link to my sales orders' do
    visit dashboard_path

    within('#merchant-orders') do
      expect(page).to_not have_link('Orders')
      expect(page).to have_content("Sorry #{@merch.name}, no one has ordered any of your items.")
    end
  end


  it 'When someone orders from me I see a link to my sales orders' do
    @user = create(:user, role: 0)
    login(@user)
    shop; checkout
    shop; checkout
    shop; checkout
    login(@merch)

    visit dashboard_path


    within('#merchant-orders') do
      expect(page).to have_link("Orders")
    end

  end

end
