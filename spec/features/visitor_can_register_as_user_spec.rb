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

    expect(current_path).to eq(new_user_path)

    fill_in :name, with: @name
    fill_in :address, with: @address
    fill_in :city, with: @city
    fill_in :city, with: @state
    fill_in :email, with: @email
    fill_in :password, with: @password
    fill_in :password_confirmation, with: @password

    click_on "Register As New User"

    expect(page).to have_content("Welcome, #{@username}, you are now registered and logged in.")
    expect(current_path).to eq(user_profile_path(user))
  end
  #
  # it 'already has the user email' do
  #
  #   visit new_user_path
  #
  #   fill_in :name, with: 'Joe'
  #   fill_in :address, with: "876 something drive"
  #   fill_in :city, with: "Harrisburg"
  #   fill_in :city, with: "Pennsylvania"
  #   fill_in :email, with: @email
  #   fill_in :password, with: '9876test'
  #   fill_in :password_confirmation, with: '9876test'
  #
  #   click_on 'Register As New User'
  #   expect(current_path).to eq(new_user_path)
  #   expect(page).to have_button("Register As New User")
  # end
end
