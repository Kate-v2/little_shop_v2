require "rails_helper"
require 'feature_helper'

describe 'Any User can CANCEL a relevant order' do
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
    mock_order([Item.first], 1, @user1)
    # order has item 1 from merch 1

    @user2 = create(:user, role: 0)
    login(@user2)
    shop; checkout
    # order has item 1 from merch 1
    # order has item 2 from merch 2

    @admin = create(:user, role: 2)

  end

  describe 'User' do

    it "can cancel their own purchased orders from the index page" do
      login(@user1)
      visit profile_orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      # -- from index --
      expect(page).to_not have_content("Status: Canceled")
      order1.click_on("Cancel Order")
      expect(page).to have_current_path(profile_orders_path)
      expect(page).to have_content("Status: Canceled")
    end

    it "can cancel their own purchased orders from the show page" do
      login(@user1)
      visit profile_orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      # -- from show --
      order1.click_on("Order: #{order.id}")
      expect(page).to have_current_path(profile_order_path(order))
      expect(page).to have_content("Status: Pending")
      click_on("Cancel Order")
      expect(page).to have_current_path(profile_order_path(order))
      expect(page).to have_content("Status: Canceled")
    end

    it "cannot cancel other user orders" do
      skip
    end

  end

  describe 'Merchant' do

    it "can cancel their own sold orders" do
      skip
    end

    it "Order Items are canceled with canceled order" do
      skip
    end

    it "cannot cancel other merchant's orders" do
      skip
    end

    it "can cancel a joint merchant order" do
      login(@merch1)
      visit dashboard_orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      # -- from show --
      order1.click_on("Order: #{order.id}")
      expect(page).to have_content("Status: Pending")
      click_on("Cancel Order")
      expect(page).to have_content("Status: Canceled")

      items = order.order_items
      other_order_item = items[1]
      other_item = items[1].item

      expect(other_item.user_id).to eq(@merch2.id)
      expect(other_order_item.status).to eq('canceled')
    end

  end

  describe 'Admin' do

    it 'can cancel merchant orders' do
      login(@admin)
      visit orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      # -- from show --
      order1.click_on("Order: #{order.id}")
      expect(page).to have_content("Status: Pending")
      click_on("Cancel Order")
      expect(page).to have_content("Status: Canceled")
    end

    it 'can cancel user orders' do
      login(@admin)
      visit merchant_orders_path(@merch1)

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      # -- from show --
      order1.click_on("Order: #{order.id}")
      expect(page).to have_content("Status: Pending")
      click_on("Cancel Order")
      expect(page).to have_content("Status: Canceled")
    end

  end

  describe 'Logistics' do

    it 'OrderItems have canceled status' do
      login(@user1)
      visit profile_orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      order1.click_on("Cancel Order")
      items = order.order_items
      status = items.all? { |item| item.status == 'canceled'  }
      expect(status).to eq(true)
    end

    it 'Inventory is returned to all Merchant(s)' do
      login(@user1)
      visit profile_orders_path

      order = Order.first
      order1 = page.find("#order-#{order.id}")

      items = order.order_items
      item  = items.first.item
      inv   = item.inventory

      order1.click_on("Cancel Order")
      items = order.order_items
      item  = items.first.item
      new_inv = item.inventory

      expect(new_inv - inv).to eq(1)
    end


  end



end
