require 'rails_helper'

describe 'cart class' do

  describe 'methods' do
    before(:each) do
      @user_1 = create(:user)
      @item_1 = Item.create(name:"dog brush", price:300, description: "it's a brush for your dog", inventory:5, user_id: @user_1.id )
      @item_2 = Item.create(name:"cat brush", price:400, description: "it's a brush for your cat", inventory:2,user_id: @user_1.id  )
      @item_3 = Item.create(name:"cat toy", price:500, description: "it's a toy for your cat", inventory:5,user_id: @user_1.id )

      @cart = Cart.new({"#{@item_1.id}"=>2,"#{@item_2.id}"=>3,"#{@item_3.id}"=>5})
    end

    it 'cart_count can count amount of items in a cart' do

      expect(@cart.cart_count).to eq(10)
    end

    it 'cart_items can return Items inside a cart' do

      expect(@cart.cart_items.length).to eq(3)
      expect(@cart.cart_items.first).to eq(@item_1)
      expect(@cart.cart_items.second).to eq(@item_2)
      expect(@cart.cart_items.third).to eq(@item_3)
    end

    it 'cart_item_total can return each items total that is within the cart' do

      expect(@cart.cart_item_total.values.first).to eq(600)
      expect(@cart.cart_item_total.values.second).to eq(1200)
      expect(@cart.cart_item_total.values.third).to eq(2500)
    end
  end
end
