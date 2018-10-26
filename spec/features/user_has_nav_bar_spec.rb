require "rails_helper"


describe 'Navigation Bar:' do

  context 'Visitor' do

    it 'HOME link' do
      visit login_path
      click_on 'Home'
      expect(page).to have_current_path(root_path)
    end

    describe 'Shop By' do
      it 'ITEMS link' do
        visit login_path
        skip('Items INDEX not created yet')
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
      skip('CART stuff does not exist yet')
      click_on 'Cart'
      expect(page).to have_current_path(cart_path)
    end

    it 'Does not have a profile path' do
      visit root_path
      expect(page).to_not have_content('Profile')
    end

  end

  describe 'Registered Users' do

    def quick_user( id = User.last.id + 1 )
      {
        name:    "name #{id}"    ,
        address: "address #{id}" ,
        city:     "city #{id}"   ,
        state:    "state #{id}"  ,
        zip:      id,
        email:    "email #{id}"  ,
        password: "password#{id}",
        role:     0,
        active:   1
      }
    end

    def log_in(user)
      visit logout_path
      visit login_path
      fill_in 'Email'   , with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log In'
    end

    before(:each) do
      @user = create(:user)
      log_in(@user)
    end

    context 'Any Registered User' do

      describe 'has retains visitor shopping interactions' do
        it 'HOME' do click_on("Home") end
        it 'ITEMS' do
          skip('items stuff does not exist yet')
          click_on("Items")
        end
        it 'MERCHANTS' do click_on("Merchants") end
        it 'Cart' do
          skip('need to click on cart div, also cart stuff does not yet exist')
          click_on("Cart")
        end
      end

      it 'User has profile' do
        expect(page).to have_content('Profile')
      end

      it 'Welcomes user' do
        expect(page).to have_content("Welcome #{@user.name}")
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
      it 'user does not have a dashboard' do
        expect(page).to_not have_content("Dashboard")
      end

      it 'user does not have a users view' do
        expect(page).to_not have_content("Users")
      end
    end

    context 'Merchant' do

      before(:each) do
        quick = quick_user; quick[:role] = 1
        @merch = User.create(quick)
        log_in(@merch)
      end

      it 'user does have a dashboard' do
        skip('Dashboard Controller needs methods')
        click_on 'Dashboard'
        expect(page).to have_current_path(dashboard_path)
      end

      it 'user does not have a users view' do
        expect(page).to_not have_content("Users")
      end
    end


    context 'Admin' do

      before(:each) do
        quick = quick_user; quick[:role] = 2
        @admin = User.create(quick)
        log_in(@admin)
      end

      it 'user does have a dashboard' do
        skip('Dashboard Controller needs methods')
        click_on 'Dashboard'
        expect(page).to have_current_path(dashboard_path)
      end

      it 'user does have a users view' do
        skip('User Controller needs methods')
        click_on 'Users'
        expect(page).to have_current_path(users_path)
      end
    end

  end

end

def page_pry
  save_and_open_page
  # binding.pry
end
