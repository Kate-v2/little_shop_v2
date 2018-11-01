class OrdersController < ApplicationController

  def create
    @items = @cart.cart_items
    user   = User.find(session[:user_id])
    @order = Order.create(status: 0, user_id: user.id)
    order_all_items
    # @count = @cart.cart_count
    session.delete(:cart)
    # unsure if this is what I want to do and/or @cart = nil
    flash[:order] = flash_messages[:successful_order]
    redirect_to profile_orders_path #(count: @count)
  end


  def index
    session[:user_id] || not_found
    index_experiences


    @user = User.find(session[:user_id].to_i)    if @user_experience || @merch_experience
    @user = User.find( params[:user_id].to_i)    if @admin_merch_experience
    orders = @user.find_merchant_order_ids.uniq  if !@admin_experience && (@user && @user.role == 'merchant') && (@admin_merch_experience || @merch_experience)
    @orders = Order.where(user_id: @user.id)     if @user
    @orders = Order.where(id: orders)            if @user && orders
    @orders = Order.all                          if @admin_experience

    if @merch_experience
      order_ids = @user.find_merchant_order_ids.uniq
      # items        = Item.where(user_id: @user.id).pluck(:id)
      # order_items  = OrderItem.where(item: items)
      # order_ids    = order_items.pluck(:order_id)
      @orders      = Order.where(id: order_ids)
    end

  end

  def show
    show_experiences
    # @user = User.find(session[:user_id].to_i) if @user_experience
    @user = User.find(session[:user_id].to_i) if @user_order_experience  || @merch_order_experience
    @user = User.find( params[:user_id].to_i) if @admin_merch_experience || @admin_order_experience
    @orders = [ Order.find(params[:id].to_i) ]
  end

  def destroy
    cancel_order
    flash[:canceled] = "Order ##{params[:id]} has been canceled."
    redirect_to params[:previous]
  end

  def update
    if request.path == fulfillment_path  && current_merchant?  # current_user.id == item.user_id ??
      fulfill_order
      redirect_to params[:previous]
    end
  end


  private

  def fulfilled() 1 end
  def canceled()  2 end

  def fulfill_order
    order_item = OrderItem.find(params[:order_item].to_i)
    item = order_item.item
    qty  = order_item.quantity
    if qty <= item.inventory
      item.inventory -= qty; item.save
      order_item.status = 1; order_item.save
      influence_order_status(order_item.order)
      flash[:fulfill] = "You have fulfilled item: #{item.name} of order: #{order_item.order_id}"
    else
      flash[:error] = flash_messages[:invalid_qty]
    end
  end

  def influence_order_status(order_id)
    order = Order.find(order_id.id)
    items = OrderItem.where(order: order )
    finalize = items.all? { |item| item.status == 'complete' }
    (order.status = fulfilled; order.save) if finalize
    # if finalize
    #   (order.status = fulfilled; order.save)
    # end
  end

  def cancel_order
    order       = Order.find(params[:id].to_i)
    order_items = order.order_items

    if order.status == 'pending'
      order.status = canceled; order.save
      order_items.each { |oitem|
        item = oitem.item
        item.inventory += oitem.quantity; item.save
        oitem.status = canceled; oitem.save
      }
    else
      flash[:error] = flash_messages[:cannot_cancel]
    end
  end

  def order_all_items
    @items.each { |item|
      qty = @cart.contents[item.id.to_s]
      OrderItem.create( item: item, order: @order, quantity: qty, purchase_price: item.price )
    }
  end

  def show_experiences
    path = request.path
    @user_order_experience  = path == profile_order_path    && current_user
    @merch_order_experience = path == dashboard_order_path  && current_merchant?
    @admin_experience       = path == order_path            && current_admin?
    admin_order_view = path == (merchant_order_path || path == order_path)      if params[:user_id]
    @admin_order_experience = (admin_order_view             && current_admin?)  if params[:user_id]
    @admin_merch_experience = (path == merchant_orders_path && current_admin?)  if params[:user_id]
    found = (
      @user_order_experience  ||
      @merch_order_experience ||
      @admin_experience       ||
      @admin_merch_experience ||
      @admin_order_experience
    )
    found || not_found
  end

  def index_experiences
    path = request.path
    @user_experience        = path == profile_orders_path    && current_user
    @merch_experience       = path == dashboard_orders_path  && current_merchant?
    @admin_experience       = path == orders_path            && current_admin?
    @admin_merch_experience = (path == merchant_orders_path  && current_admin?) if params[:user_id]
    found = (
      @user_experience        ||
      @merch_experience       ||
      @admin_experience       ||
      @admin_merch_experience
    )
    found || not_found
  end

  def flash_messages
    {
      cannot_cancel:    "Sorry, this order can no longer be canceled.",
      invalid_qty:      "Order quantity exceeds inventory.",
      successful_order: "Thank you for your purchase! Order Number: #{@order.id}"
    }
  end


end
