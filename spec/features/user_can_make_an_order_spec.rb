require "rails_helper"


describe 'User can make purchases' do

  before(:each) do
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    @user = create(:user, role: 0)
    log_in(@user)
  end

  it 'User can click Check Out' do
    shop; checkout
    expect(page).to have_current_path(profile_orders_path)
  end

  it 'User sees a notification that the order has been made' do
    shop; checkout
    order = Order.last
    expect(page).to have_content("Thank you for your purchase! Order Number: #{order.id}")
  end

  it 'User can see new order in their list of orders' do
    shop; checkout
    order = Order.last
    skip('build view')
    recent = page.find("#order-##{order.id}")
    expect(recent).to have_content(order.id)
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
end

def checkout
  visit cart_path
  click_on 'Check Out'
end
