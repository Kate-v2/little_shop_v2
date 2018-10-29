class CartController < ApplicationController

  def index
    @items = @cart.cart_items
    @item_sum = @cart.cart_item_total
    @cart_sum = @item_sum.values.sum
  end

  def destroy
    if params[:delete_item]
      session[:cart].delete(params[:item_id].to_s)
    elsif params[:delete_cart]
      session[:cart] = nil
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    item = Item.find(params[:item_id])
    new_qty = params[:number].to_i
    original_qty = session[:cart][params[:item_id]].to_i
    session[:cart][params[:item_id]] = params[:number].to_i unless new_qty > item.inventory
    if original_qty - new_qty == 1
      flash[:success] = "#{item.name.capitalize} removed from cart"
    elsif original_qty == item.inventory
      flash[:error] = "Only #{item.inventory} in stock"
    elsif original_qty - new_qty == -1
      flash[:success] = "#{item.name.capitalize} added to cart"
    end
    redirect_back(fallback_location: root_path)
  end

  def create
    session[:cart] ||= Hash.new(0)
    item = Item.find(params[:item_id])
    session[:cart][item.id.to_s] ||= 0
    session[:cart][item.id.to_s] += 1
    flash[:success] = "#{item.name.capitalize} added to cart"
    redirect_back(fallback_location: root_path)
  end

end
