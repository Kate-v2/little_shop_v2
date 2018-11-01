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

  it 'Can click title to view order show page' do
    order = Order.first
    id    = order.id
    click_on "Order: #{id}"
    expect(page).to have_current_path(dashboard_order_path(order))
  end

  describe 'Displayed Orders are specific to Merchant' do

    it 'does not display orders irrelevant to current merchant' do
      order1 = Order.all[0]
      order2 = Order.all[1]
      expect(page).to     have_content("Order: #{order1.id}")
      expect(page).to     have_content("Order: #{order2.id}")
      expect(page).to_not have_content("Order: #{@excluded_order.id}")
    end

    it 'only displays order details provided by current merchant' do
      order = Order.first
      items = OrderItem.where(order: order)
      expect(items.count).to eq(2)
      item  = Item.first

      order1 = page.find("#order-#{order.id}")
      expect(order1).to have_content("Item Count: 1")
      expect(order1).to have_content("Checkout Cost: #{number_to_currency(item.price)}")
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

        before(:each) do
          @order = Order.first
          visit dashboard_order_path(@order)
          id = @order.id
          @card  = page.find("#order-#{id}")
          @item  = @order.items.first
          @order_item = @order.order_items.first
        end

        describe 'Order Item data:' do

          it 'Current Price' do
            item_price = number_to_currency(@item.price)
            expect(@card).to have_content("Current: #{item_price}")
          end

          it 'Purchase Price' do
            item_purchase_price = number_to_currency(@order_item.purchase_price)
            expect(@card).to have_content("Purchased: #{item_purchase_price}")
          end

          it 'Item Quantity' do
            expect(@card).to have_content("Qty: #{@order_item.quantity}")
          end

          it 'Subtotal' do
            subtotal = number_to_currency(@order_item.quantity * @order_item.purchase_price)
            expect(@card).to have_content("Sum: #{subtotal}")
          end
        end

        describe 'Order data:' do

          it 'Contains Users Shipping Info' do

            shipping = page.find(".ship-to")
            expect(shipping).to have_content(@user1.name)
            expect(shipping).to have_content(@user1.address)
            expect(shipping).to have_content(@user1.city)
            expect(shipping).to have_content(@user1.state)
            expect(shipping).to have_content(@user1.zip)
          end
        end

      end
    end

  end
end
