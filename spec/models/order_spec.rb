require 'rails_helper'

describe Order, type: :model do
  describe 'Relationships' do
    it {should have_many(:items)}
    it {should have_many(:order_items)}
    it {should belong_to(:user)}
    #alias column customer_id and merchant_id
  end

  describe 'Validations' do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:user_id)}
  end

  describe 'Making Orders' do

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

      @total_cost  = 1 + (2*2) + (3*3)
      @total_count = 6
    end

    describe 'Creation' do

      it 'pending  with status: 0' do
        pending = Order.create(status: 0, user:@user)
        expect(pending.status).to eq("pending")
      end

      it 'complete with status: 1' do
        complete = Order.create(status: 1, user:@user)
        expect(complete.status).to eq("complete")
      end

      it 'canceled with status: 2' do
        canceled = Order.create(status: 2, user:@user)
        expect(canceled.status).to eq("canceled")
      end
    end

    describe 'Order Details' do

      it 'calculates total cost' do
        cost = @order.total_cost
        expect(cost).to eq(@total_cost)
      end

      it 'calculates total item count' do
        count = @order.item_count
        expect(count).to eq(@total_count)
      end
    end


  end
end
