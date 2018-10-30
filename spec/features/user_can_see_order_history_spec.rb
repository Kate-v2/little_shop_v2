require "rails_helper"
require 'feature_helper'

describe 'Order History' do
  include FeatureHelper
  include ActionView::Helpers::NumberHelper


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
    total = number_to_currency(purchase.total_cost)

    order = page.find("#order-#{purchase.id}")
    expect(order).to have_content(id)
    expect(order).to have_content("Status: #{status.capitalize}")
    expect(order).to have_content("Ordered: #{created}")
    expect(order).to have_content("Updated: #{updated}")
    expect(order).to have_content("#{count} items")
    expect(order).to have_content("Total: #{total}")
    expect(order).to have_content("Cancel Order")
  end

  it 'displays all orders' do
    orders = page.all('.order').count
    db_orders = Order.count
    expect(orders).to eq(db_orders)
  end

  it "links to each order's show page" do
    last = Order.last
    order = page.find("#order-#{last.id}")
    order.click_on("Order: #{last.id}")
    expect(page).to have_current_path(profile_order_path(last))
  end

  it 'can cancel pending orders' do
    last  = Order.last
    order = page.find("#order-#{last.id}")
    order.click_on("Cancel Order")

    expect(page).to have_current_path(profile_orders_path)
    expect(page).to have_content("Order ##{last.id} has been canceled")

    order = page.find("#order-#{last.id}")
    expect(order).to have_content("Canceled")
  end

end
