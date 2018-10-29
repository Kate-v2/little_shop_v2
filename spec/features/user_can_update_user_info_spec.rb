require 'rails_helper'

describe 'when user visits their profile page' do

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

  it 'they see a link to update their user info' do
    visit user_path(@user)

    expect(page).to have_link('Update Info')
  end

  it 'can update user info' do
    visit user_path(@user)

    click_on('Update Info')

    fill_in 'Name', with: 'Jimmy Smith'
    fill_in 'Address', with: 'Over there street'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip', with: '12345'
    fill_in 'Email', with: 'JimmySmith@gmail.com'

    click_on 'Update User'

    expect(page).to have_content('Jimmy Smith')
    expect(page).to have_content('Address: Over there street')
    expect(page).to have_content('City: Denver')
    expect(page).to have_content('State: Colorado')
    expect(page).to have_content('Zip Code: 12345')
    expect(page).to have_content('Email: JimmySmith@gmail.com')
    expect(page).to have_content('You have successfully updated your info')
  end

end
