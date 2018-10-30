require "rails_helper"
require 'feature_helper'

describe 'Any User can CANCEL a relevant order' do
  include FeatureHelper

  before(:each) do
    # -- shops --
    # @merch1 = create(:user, role: 1)
    # create_list(:item, 1, user_id: @merch1.id)
    #
    # @merch2 = create(:user, role: 1)
    # create_list(:item, 1, user_id: @merch2.id)
    #
    # # -- purchasers --
    # @user1 = create(:user, role: 0)
    # login(@user1)
    # shop; checkout
    # # order has item 1 from merch 1
    # # order has item 2 from merch 2
    #
    # @user2 = create(:user, role: 0)
    # login(@user2)
    # shop; checkout
    # # order has item 1 from merch 1
    # # order has item 2 from merch 2
    #
    # item = Item.where(user_id: @merch3.id)
    # @excluded_order = mock_order(item, 2, @user1 )
    #
    # # --- Merchant Experience ---
    # login(@merch1)
    # visit dashboard_orders_path
  end

  describe 'User' do

    it "can cancel their own purchased orders" do
      skip
    end

    it "cannot cancel other user orders" do
      skip
    end

    it "Order Items are canceled with canceled order" do
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
      skip
    end

  end

  describe 'Admin' do

    it 'can cancel merchant orders' do
      skip
    end

    it 'can cancel user orders' do
      skip
    end

    it "Order Items are canceled with canceled merchant order" do
      skip
    end

    it "Order Items are canceled with canceled user order" do
      skip
    end


  end



end
