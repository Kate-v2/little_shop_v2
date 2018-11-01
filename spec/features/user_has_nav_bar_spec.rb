require "rails_helper"
require "feature_helper"

describe 'Navigation Bar:' do
  include FeatureHelper

  context 'Visitor' do

    it 'HOME link' do
      visit login_path
      click_on 'Home'
      expect(page).to have_current_path(root_path)
    end

    describe 'Shop By' do
      it 'ITEMS link' do
        visit login_path
        click_on 'Items'
        expect(page).to have_current_path(items_path)
      end

      it 'MERCHANTS link' do
        visit login_path
        click_on 'Merchants'
        expect(page).to have_current_path(merchants_path)
      end
    end

    it 'REGISTER link' do
      visit root_path
      click_on 'Register'
      expect(page).to have_current_path(register_path)
    end

    it 'LOGIN link' do
      visit root_path
      click_on 'Login'
      expect(page).to have_current_path(login_path)
    end

    it 'CART link' do
      visit root_path
      click_on 'Cart'
      expect(page).to have_current_path(cart_path)
    end

    it 'Does not have a profile path' do
      visit root_path
      expect(page).to_not have_content('Profile')
    end

  end

  describe 'Registered Users' do

    before(:each) do
      @user = create(:user)
      login(@user)
    end

    context 'Any Registered User' do

      describe 'retains visitor shopping interactions' do
        it 'HOME'      do click_on("Home")      end
        it 'ITEMS'     do click_on("Items")     end
        it 'MERCHANTS' do click_on("Merchants") end
        it 'Cart'      do click_on("Cart")      end
      end

      it 'User has profile' do
        expect(page).to have_content('Profile')
      end

      it 'Welcomes user' do
        expect(page).to     have_content("Welcome #{@user.name}")
        expect(page).to_not have_content("Welcome! Please")
        expect(page).to_not have_content("Login")
        expect(page).to_not have_content("Register")
      end

      it 'User Can Log out' do
        click_on 'Log Out'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("Login")
      end

    end

    context 'User' do
      it 'does not have a dashboard' do
        expect(page).to_not have_content("Dashboard")
      end

      it 'does not have a users view' do
        expect(page).to_not have_content("Users")
      end
    end

    context 'Merchant' do

      before(:each) do
        @merch = create(:user, role: 1)
        login(@merch)
      end

      it 'does have a dashboard' do
        click_on 'Dashboard'
        expect(page).to have_current_path(dashboard_path)
      end

      it 'does not have a users view' do
        expect(page).to_not have_content("Users")
      end
    end


    context 'Admin' do

      before(:each) do
        @admin = create(:user, role: 2)
        login(@admin)
      end

      it 'does have a dashboard' do
        click_on 'Dashboard'
        expect(page).to have_current_path(dashboard_path)
      end

      it 'does have a users view' do
        expect(page).to have_content('Users')
        click_on 'Users'
        expect(page).to have_current_path(users_path)
      end

      it 'does have an orders view' do
        expect(page).to have_content('Orders')
        click_on 'All Orders'
        expect(page).to have_current_path(orders_path)
      end
    end

  end

end
