require "rails_helper"


describe 'User can click checkout button to purchase cart' do

  before(:each) do
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)

    @user = create(:user, role: 0)
    log_in(@user)



  end

  it 'test' do
    shop
    checkout
    expect(page).to have_current_path(profile_orders_path)
  end





end



# --- TOOLS ---

def log_in(user)
  visit logout_path
  visit login_path
  fill_in 'Email'   , with: user.email
  fill_in 'Password', with: user.password
  click_on 'Log In'
end

def shop
  visit items_path
  browse = page.all('.item')

  # first item, qty = 1
  first = browse[0]
  first.click_on('Add Item')
  # second item, qty = 2
  second = browse[1]
  second.click_on('Add Item')
  second = page.all('.item')[1]
  second.click_on('+')
  # first.find('Add Item').click
  # first.find('+').click
end

def checkout
  visit cart_path
  click_on 'Check Out'
end
