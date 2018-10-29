require "rails_helper"
require 'feature_helper'

describe 'Order History' do
  include FeatureHelper

  before(:each) do
    # -- shop --
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    # -- purchaser --
    @user = create(:user, role: 0)
    login(@user)
    shop; checkout
    shop; checkout
    shop; checkout
    visit profile_orders_path
  end

  it 'displays an order' do
    purchase = Order.first
    id      = purchase.id
    created = purchase.created_at
    updated = purchase.updated_at
    status  = purchase.status
    count   = purchase.item_count
    total   = purchase.total_cost

    order = page.find("#order-#{purchase.id}")
    expect(order).to have_content(id)
    expect(order).to have_content("Status: #{status}")
    expect(order).to have_content("Ordered: #{created}")
    expect(order).to have_content("Updated: #{updated}")
    expect(order).to have_content("#{count} items")
    expect(order).to have_content("Total: $#{total}")
  end

  it 'displays all orders' do

  end




end
