require 'rails_helper'

describe OrderItem, type: :model do
  describe 'Relationships' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
    # it {should belong_to(:user)} user is purchaser
  end

  describe 'Validations' do
    it {should validate_presence_of(:order)}
    it {should validate_presence_of(:item)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:purchase_price)}
  end

  describe 'create' do
    before(:each) do
      # -- store ---
      @merch = create(:user, role: 1)
      @items_in_shop = 3
      create_list(:item, @items_in_shop, user_id: @merch.id)

      # -- purchase --
      @user = create(:user, role: 0)
      @order = Order.create!(status: 'pending', user: @user)

      @item1 = OrderItem.create!(order: @order, item: Item.all[0], quantity: 1, purchase_price: 1)
      @item2 = OrderItem.create!(order: @order, item: Item.all[1], quantity: 2, purchase_price: 2)
      @item3 = OrderItem.create!(order: @order, item: Item.all[2], quantity: 3, purchase_price: 3)

      @total_cost_should  = 1 + (2*2) + (3*3)
      @total_count_should = 6
    end

    it 'should have default status of pending' do
      pending = OrderItem.first.status
      expect(pending).to eq('pending')
    end

    describe 'Subtotals' do

      it 'should create a temporary table with subtotals calculated for each row' do
        tmp = OrderItem.with_subtotals
        expect(tmp.all.length).to eq(@items_in_shop)

        bought1 = tmp[0]
        bought2 = tmp[1]
        bought3 = tmp[2]
        expect(bought1.subtotal).to eq(@item1.quantity * @item1.purchase_price)
        expect(bought2.subtotal).to eq(@item2.quantity * @item2.purchase_price )
        expect(bought3.subtotal).to eq(@item3.quantity * @item3.purchase_price )
      end
    end



  end


end
