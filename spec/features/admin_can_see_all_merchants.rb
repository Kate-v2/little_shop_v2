require 'rails_helper'
require 'feature_helper'

describe 'As an admin' do

  include FeatureHelper

  describe 'when I visit /mechants' do

    before(:each) do
      @admin = create(:user, role: 2)
      # -- shop --
      @merch_1 = create(:user, role: 1)
      @merch_2 = create(:user, role: 1)
      @merch_3 = create(:user, role: 1)
      create_list(:item, 3, user_id: @merch_1.id)
      create_list(:item, 4, user_id: @merch_2.id)
      create_list(:item, 5, user_id: @merch_3.id)
      # -- purchaser --
      @user_1 = create(:user, role: 0)
      @user_2 = create(:user, role: 0)
      @user_3 = create(:user, role: 0)
      @user_4 = create(:user, role: 0)
      login(@user_1)
      shop; checkout
      shop; checkout
      shop; checkout
      login(@user_2)
      shop; checkout
      shop; checkout
      shop; checkout
      login(@user_3)
      shop; checkout
      shop; checkout
      shop; checkout
      login(@user_4)
      shop; checkout
      shop; checkout
      shop; checkout
      login(@admin)
    end

    it 'I see a list of all the merchants' do
      visit merchants_path

      expect(page).to have_content(@merch_1.name)
      expect(page).to have_content(@merch_2.name)
      expect(page).to have_content(@merch_3.name)
    end

    it 'Each merchant name is a link to their respective show page' do
      visit merchants_path
      click_on(@merch_1.name)
      expect(current_path).to eq(user_path(@merch_1))

      visit merchants_path
      click_on(@merch_2.name)
      expect(current_path).to eq(user_path(@merch_2))

      visit merchants_path
      click_on(@merch_3.name)
      expect(current_path).to eq(user_path(@merch_3))
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

      binding.pry

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

      visit merchants_path

      login(@merch_1)

      expect(current_path).to_not eq(profile_path(@merch_1))
      expect(page).to_not have_content(@merch_1.name)
    end

  end

end
