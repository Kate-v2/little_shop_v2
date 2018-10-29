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

    order = page.find("order-#{Order.first.id}")
    expect(order).to have_content(id)
    expect(order).to have_content(created_at)
    expect(order).to have_content(updated_at)
    expect(order).to have_content(status)
    expect(order).to have_content(count)
    expect(order).to have_content(total)
  end

  it 'displays all orders' do

  end




end
