class OrdersController < ApplicationController

  def create
    @items = @cart.cart_items
    user   = User.find(session[:user_id])
    @order = Order.create(status: 0, user_id: user.id)
    order_all_items
    # @count = @cart.cart_count
    session.delete(:cart)
    # unsure if this is what I want to do and/or @cart = nil
    flash[:order] = "Thank you for your purchase! Order Number: #{@order.id}"
    redirect_to profile_orders_path #(count: @count)
  end


  def index
    @user = User.find(session[:user_id].to_i)
    @path  = request.path
    @user_experience  = @path == profile_orders_path   && current_user
    @merch_experience = @path == dashboard_orders_path && current_merchant? # || current_admin
    @admin_experience = @path == orders_path           && current_admin?

    # if none of the experiences, show 404 page

    # @orders = Order.where(user_id: @user.id) if user_experience
    # @orders = Order.all                      if admin_experience

    if @user_experience
      @orders = Order.where(user_id: @user.id)
      # order_items?
    end

    if @admin_experience
      @orders = Order.all

    end


    if @merch_experience
      items        = Item.where(user_id: @user.id).pluck(:id)
      @order_items = OrderItem.where(item: items)
      order_ids    = @order_items.pluck(:order_id)
      @orders      = Order.where(id: order_ids)
    end

  end

  def show
    path = request.path
    experience1 = path == order_path && current_merchant?
    experience2 = path == order_path && current_admin?
    @merch_order_experience = experience1 || experience2
    # binding.pry
    @orders = [ Order.find(params[:id].to_i) ]
  end

  def destroy
    order = Order.find(params[:id].to_i)
    order.status = 2; order.save
    flash[:canceled] = "Order ##{order.id} has been canceled."
    redirect_to params[:previous]
  end

  def update
    binding.pry
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
