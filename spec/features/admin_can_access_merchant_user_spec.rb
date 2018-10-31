
require 'rails_helper'

describe 'when admin visits registered user page' do

  before(:each) do
    @user = create(:user)
    @admin = create(:user,role:2)
    @merch = create(:user,role:1)
    visit login_path
    fill_in :email,    with: @admin.email
    fill_in :password, with: @admin.password
    click_button 'Log In'
  end

  it 'there are links to upgrade their account' do

    visit user_path(@user)

    expect(page).to have_content("Upgrade Account")
  end

  it 'the upgrade link changes path to merchant profile path' do
    skip('MEGHAN FIXED THIS I BELEIVE!')
    visit user_path(@user)

    click_on("Upgrade Account")


    expect(current_path).to eq("/merchants/#{@user.id}")
    # expect(page).to have_content("#{@user.name.capitalize} has now been upgraded to a merchant.")
  end


end
