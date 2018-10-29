describe 'As a registered user, merchant, or admin' do

  describe 'When I visit my own profile page, I see my' do

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

    it 'name' do
      visit login_path

      expect(page).to have_content(@user.name)
    end

    it 'address' do
      visit login_path

      expect(page).to have_content(@user.address)
    end

    it 'city' do
      visit login_path

      expect(page).to have_content(@user.city)
    end

    it 'state' do
      visit login_path

      expect(page).to have_content(@user.state)
    end

    it 'zip' do
      visit login_path

      expect(page).to have_content(@user.zip)
    end

    it 'email' do
      visit login_path

      expect(page).to have_content(@user.email)
    end

  end

end
