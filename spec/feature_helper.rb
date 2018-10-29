
module FeatureHelper

  def page_pry
    save_and_open_page
    binding.pry
  end

  def login(user)
    # binding.pry
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

end
