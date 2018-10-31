require 'rails_helper'

describe 'user registration' do

  before(:each) do
    @name = "John Smith"
    @address = "123 Appleseed Drive"
    @city = "Chatanooga"
    @state = "Tennessee"
    @zip = 12345
    @email = "jsmith123@gmail.com"
    @password = "test1234"
  end

  it 'with valid credentials' do
    visit root_path

    click_on "Register"

    expect(current_path).to eq(register_path)
    fill_in "Name", with: @name
    fill_in "Address", with: @address
    fill_in "City", with: @city
    fill_in "State", with: @state
    fill_in "Zip", with: @zip
    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Confirm password", with: @password

    click_on "Register As New User"
    expect(current_path).to eq(profile_path)
    expect(page).to have_content("You are now registered and logged in")
  end

  it 'renders new with not enough credentials' do
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
    expect(current_path).to eq(users_path)
  end

  it 'already has the user email' do
    visit root_path

    click_on "Register"

    expect(current_path).to eq(register_path)
    fill_in "Name", with: @name
    fill_in "Address", with: @address
    fill_in "City", with: @city
    fill_in "State", with: @state
    fill_in "Zip", with: @zip
    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Confirm password", with: @password

    click_on "Register As New User"
    visit logout_path
    
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
