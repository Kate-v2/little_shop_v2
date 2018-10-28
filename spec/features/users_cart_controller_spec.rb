require 'rails_helper'

describe 'cart' do
  before(:each) do
    @user_1 = create(:user)
    @item_1 = Item.create(name:"dog brush", price:300, description: "it's a brush for your dog", inventory:5, user_id: @user_1.id )
    @item_2 = Item.create(name:"cat brush", price:400, description: "it's a brush for your cat", inventory:2,user_id: @user_1.id  )
    @item_3 = Item.create(name:"cat toy", price:500, description: "it's a toy for your cat", inventory:5,user_id: @user_1.id )

    @cart = Cart.new({"#{@item_1.id}"=>2,"#{@item_2.id}"=>3,"#{@item_3.id}"=>5})
  end
  it 'displays flash message when item added to cart from items_show' do
    visit items_path

    click_on "Add Item"

    expect(page).to have_content(flash[:success])

  end

  # it 'display increments in navbar by one everytime I add an item' do
  #   visit items_path
  #
  #   click_on "+"
  #
  # end
  #
  # it 'displays flash message when item added to cart from item_show' do
  #   visit items_path
  #
  #   click_on "+"
  #
  #
  # end

end
