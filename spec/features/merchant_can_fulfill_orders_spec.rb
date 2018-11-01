require "rails_helper"
require 'feature_helper'

describe 'Merchant can fulfill order' do
  include FeatureHelper

  before(:each) do
   # -- shops --
   @merch1 = create(:user, role: 1)
   create_list(:item, 1, user_id: @merch1.id)

   @merch2 = create(:user, role: 1)
   create_list(:item, 1, user_id: @merch2.id)

   # -- purchasers --
   @user1 = create(:user, role: 0)
   login(@user1)
   shop; checkout
   # order has item 1 from merch 1
   # order has item 2 from merch 2
   @order = mock_order([Item.first], 1, @user1)
   # order has item 1 from merch 1

   @user2 = create(:user, role: 0)
   login(@user2)
   shop; checkout

 end

  it 'can click fulfill' do
    visit logout_path
    login(@merch1)
    visit dashboard_orders_path
    click_on(@order.id)
    click_on('Fulfill')
  
    expect(page).to have_content("You have fulfilled item: #{Item.first.name}")
    expect(page).to have_content("This order is fulfilled")
  end

  describe 'Order Status' do

    it "completes order of only this merchant's item" do
      skip
    end

    it "does not complete joint merchant orders" do
      skip
    end

    it "completes orders that are partailly complete" do
      skip
    end
  end

  describe 'Order Items' do

    it 'updates order items to fulfilled status' do
      skip
    end

    it 'affects item inventory' do
      skip
    end

  end

  describe 'Admin' do

    it 'Admin cannot fulfill orders' do
      skip
    end

  end


end
