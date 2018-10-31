require 'rails_helper'
require 'feature_helper'

describe 'As an admin' do

  include FeatureHelper

  before(:each) do
    @admin = create(:user, role: 2)
    # -- shop --
    @merch_1 = create(:user, role: 1)
    @merch_2 = create(:user, role: 1)
    @merch_3 = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch_1.id)
    create_list(:item, 4, user_id: @merch_2.id)
    create_list(:item, 5, user_id: @merch_3.id)
    login(@admin)
  end

  describe 'when I visit /merchants' do

    it 'I see a list of all the merchants' do
      visit merchants_path

      expect(page).to have_content(@merch_1.name)
      expect(page).to have_content(@merch_2.name)
      expect(page).to have_content(@merch_3.name)
    end

    it 'Each merchant name is a link to their respective show page' do
      visit merchants_path
      click_on(@merch_1.name)
      expect(current_path).to eq(merchant_show_path(@merch_1))

      visit merchants_path
      click_on(@merch_2.name)
      expect(current_path).to eq(merchant_show_path(@merch_2))

      visit merchants_path
      click_on(@merch_3.name)
      expect(current_path).to eq(merchant_show_path(@merch_3))
    end

    it 'I see a button to disable each enabled merchant' do
      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        expect(page).to have_button('Disable')
      end
      within("#merchant-#{@merch_2.id}") do
        expect(page).to have_button('Disable')
      end
      within("#merchant-#{@merch_2.id}") do
        expect(page).to have_button('Disable')
      end
    end

    it 'I see a button to enable each disabled merchant' do
      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        click_on('Disable')
      end

      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        expect(page).to have_button('Enable')
      end
    end

    it 'when I click on disable, merchant cant login' do
      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        click_button('Disable')
      end

      login(@merch_1)

      expect(current_path).to_not eq(profile_path)
      expect(page).to_not have_content(@merch_1.name)
    end

    it 'when I click on enable, merchant can login' do
      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        click_button('Disable')
      end

      visit merchants_path

      within("#merchant-#{@merch_1.id}") do
        click_button('Enable')
      end

      login(@merch_1)

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(@merch_1.name)
    end

  end

  describe 'When I visit a merchants dashboard' do

    before(:each) do
      visit merchant_show_path(@merch_1)
    end

    it 'uri is correct' do
      expect(current_path).to eq "/merchants/#{@merch_1.id}"
      expect(page).to have_link('Update Info')
    end

    it 'I can update a merchants info' do
      click_on('Update Info')

      fill_in 'Name', with: 'Joe Schmoe'
      fill_in 'Address', with: '1800 street'
      fill_in 'City', with: 'Denverville'
      fill_in 'State', with: 'Colorassi'
      fill_in 'Zip', with: '09876'
      fill_in 'Email', with: 'Kickball@kickball.com'

      click_on('Update User')

      expect(current_path).to eq(merchant_show_path(@merch_1))
      expect(page).to have_content("Joe Schmoe's")
    end

  end

end
