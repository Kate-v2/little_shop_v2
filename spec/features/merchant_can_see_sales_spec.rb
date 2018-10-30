require "rails_helper"
require 'feature_helper'

describe 'Merchant Sold Orders' do
  include FeatureHelper
  include ActionView::Helpers::NumberHelper

  before(:each) do
    # -- shops --
    @merch1 = create(:user, role: 1)
    create_list(:item, 1, user_id: @merch1.id)

    @merch2 = create(:user, role: 1)
    create_list(:item, 1, user_id: @merch2.id)

    @merch3 = create(:user, role: 1)
    create_list(:item, 1, user_id: @merch3.id)

    # -- purchasers --
    @user1 = create(:user, role: 0)
    login(@user1)
    shop; checkout
    # order has item 1 from merch 1
    # order has item 2 from merch 2

    @user2 = create(:user, role: 0)
    login(@user2)
    shop; checkout
    # order has item 1 from merch 1
    # order has item 2 from merch 2

    item = Item.where(user_id: @merch3.id)
    @excluded_order = mock_order(item, 2, @user1 )

    # --- Merchant Experience ---
    login(@merch1)
    visit dashboard_orders_path
  end

  it 'Orders were made by other users' do
    order = page.all('.order').first
    expect(order).to_not have_content(@merch1.name)
  end

  it 'All Merchant provided orders are displayed' do
    orders = page.all('.order').count
    expect(orders).to eq(2)
  end

  describe 'Displayed Orders are specific to Merchant' do

    it 'does not display orders irrelevant to current merchant' do
      order1 = Order.all[0]
      order2 = Order.all[1]
      expect(page).to     have_content(order1.id)
      expect(page).to     have_content(order2.id)
      expect(page).to_not have_content(@excluded_order.id)
    end

    it 'only displays order items provided by current merchant' do
      order = Order.first
      items = OrderItem.where(order: order)
      expect(items.count).to eq(2)

      this_merch_item  = Item.all[0]
      other_merch_item = Item.all[1]
      expect(other_merch_item.user_id).to eq(@merch2.id)

      order1 = page.find("#order-#{order.id}")
      expect(order1).to     have_content(this_merch_item.name)
      expect(order1).to     have_content(this_merch_item.name)
      expect(order1).to_not have_content(other_merch_item.name)
    end

    describe 'order details are specific to the merchant and not the whole order' do

      it 'item count is only of merchant items' do
        order = Order.first
        order1 = page.find("#order-#{order.id}")
        expect(order1).to have_content("Item Count: 1")
      end

      it 'total cost is only of merchant items' do
        order = Order.first
        item  = order.order_items.with_subtotals[0]
        order1 = page.find("#order-#{order.id}")
        expect(order1).to have_content("Checkout Cost: #{number_to_currency(item.subtotal)}")
      end
    end

    describe 'Order Show Page' do

      describe 'order shows expected data' do

        it 'Current Price' do
          order = Order.first
          id    = order.id
          click_on "Order: #{id}"
          expect(page).to have_current_path(order_path(order))
        end




      end


    end




  end



end
