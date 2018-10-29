require 'rails_helper'

describe 'cart' do
  describe 'when I visit my cart page' do
    before(:each) do
      @user_1 = create(:user)
      @item_1 = Item.create(name:"dog brush", price:300, description: "it's a brush for your dog", inventory:5, user_id: @user_1.id )
      @item_2 = Item.create(name:"cat brush", price:400, description: "it's a brush for your cat", inventory:2,user_id: @user_1.id  )
      @item_3 = Item.create(name:"cat toy", price:500, description: "it's a toy for your cat", inventory:5,user_id: @user_1.id )

      @cart = Cart.new({"#{@item_1.id}"=>2,"#{@item_2.id}"=>3,"#{@item_3.id}"=>5})
      visit item_path(@item_1)
      click_on "Add Item"
      visit item_path(@item_2)
      click_on "Add Item"
    end

    it 'I see all items that were added to my cart' do

      visit cart_path
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
    end

    it 'has a link that allows me to empty the cart' do

      visit cart_path
      click_on "Empty Cart"
      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      expect(current_path).to eq(cart_path)
      expect(page).to have_content("CART: 0")
    end

    it 'has info about each item in my cart' do

      visit cart_path
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.image)
      expect(page).to have_content(@item_1.user.name)
      expect(page).to have_content(@item_1.price)
      # expect(@cart.contents[@item_1.id.to_s]).to eq(1)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.image)
      expect(page).to have_content(@item_2.user.name)
      expect(page).to have_content(@item_2.price)
      # expect(@cart.contents[@item_2.id.to_s]).to eq(1)

      expect(page).to have_content("Item total: $300")
      expect(page).to have_content("Item total: $400")
      expect(page).to have_content("Cart Total: $700")
      expect(page).to have_content("Remove Item From Cart")

    end

    it 'does not allow me to add more than inventory amount to cart' do
      visit item_path(@item_1)
      click_on "+"
      click_on "+"
      click_on "+"
      visit cart_path
      expect(@cart.contents[@item_1.id.to_s]).to eq(2)
    end
  end
  describe 'when I visit the item show page' do
    it 'a flash message and increment when added item from item show page' do
      user_1 = create(:user)
      item_1 = Item.create(name:"dog brush", price:300, description: "it's a brush for your dog", inventory:5, user_id: user_1.id )
      visit item_path(item_1)

      click_on "Add Item"

      expect(page).to have_content("#{item_1.name.capitalize} added to cart")
      expect(page).to have_content("CART: 1")
    end
  end




end
