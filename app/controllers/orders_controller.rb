class OrdersController < ApplicationController

  def create
    @items = @cart.cart_items
    @user  = User.find(session[:user_id])
    @order = Order.create(status: 0, user_id: @user.id)
    order_all_items
    

  end




  private

  def order_all_items
    @items.each { |item|
      qty = @cart.contents[item.id.to_s]
      OrderItem.create( item: item, order: @order, quantity: qty,
                        purchase_price: item.price
                      )
     }
  end



end
