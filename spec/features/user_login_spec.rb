require 'rails_helper'

 describe 'login process' do

  describe 'can login as registered users' do

    before(:each) do
      @user_1, @user_2 = create_list(:user, 2)
    end

    it 'should succeed if credentials are correct' do
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{@user_1.name}")

    end

    it 'should be able to log out user' do
      visit login_path

      fill_in :email,    with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
      expect(page).to_not have_content("Register")

      click_on 'Log Out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Register")
      expect(page).to have_content("You have logged out of your account")
    end

    it 'should fail if credentials are incorrect' do
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: 'bad password'
      click_on 'Log In'
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect email/password combination.")
    end

    it 'should fail if credentials are empty' do
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: ''
      click_on 'Log In'
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect email/password combination.")

      fill_in :email, with: ''
      fill_in :password, with: @user_1.password
      click_on 'Log In'
      expect(page).to have_content("Incorrect email/password combination.")
    end

  end
end
