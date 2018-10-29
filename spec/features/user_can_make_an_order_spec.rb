require "rails_helper"
require 'feature_helper'



describe 'User can make purchases' do
  include FeatureHelper

  before(:each) do
    # -- shop --
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    # -- purchaser --
    @user = create(:user, role: 0)
    login(@user)
  end

  it 'User can click Check Out' do
    shop; checkout
    expect(page).to have_current_path(profile_orders_path)
  end

  it 'User sees a notification that the order has been made' do
    shop; checkout
    order = Order.last
    expect(page).to have_content("Thank you for your purchase! Order Number: #{order.id}")
  end

  it 'User can see new order in their list of orders' do
    shop; checkout
    order = Order.last
    recent = page.find("#order-#{order.id}")
    expect(recent).to have_content(order.id)
  end


end
