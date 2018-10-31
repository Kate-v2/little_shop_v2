require 'rails_helper'

describe 'user registration' do

  before(:each) do
    @name = "John Smith"
    @address = "123 Appleseed Drive"
    @city = "Chatanooga"
    @state = "Tennessee"
    @email = "jsmith123@gmail.com"
    @password = "test1234"
    @user = User.new(name: @name, address: @address, city: @city,
      state: @state, email: @email, password: @password,
      password: @password)
  end

  it 'with valid credentials' do
    # I want this to first visit root_path, then click on "register" from the nav bar, and then expect the current_path to equal new_user_path
    visit root_path

    click_on "Register"

    expect(current_path).to eq(register_path)
    fill_in "Name", with: @name
    fill_in "Address", with: @address
    fill_in "City", with: @city
    fill_in "State", with: @state
    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Confirm password", with: @password

    click_on "Register As New User"

    expect(current_path).to eq(users_path(@user))
    # expect(page).to have_content(flash[:register])
  end
  #
  it 'already has the user email' do

    visit new_user_path

    fill_in "Name", with: "Joe"
    fill_in "Address", with: "876 something drive"
    fill_in "City", with: "Harrisburg"
    fill_in "State", with: "Pennsylvania"
    fill_in "Email", with: @email
    fill_in "Password", with: '9876test'
    fill_in "Confirm password", with: '9876test'

    click_on 'Register As New User'
    expect(current_path).to eq(users_path)
    expect(page).to have_button("Register As New User")
  end
end
