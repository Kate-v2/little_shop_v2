class CartController < ApplicationController

  def index

  end

  def destroy

  end

  def update

  end

  def create
    session[:cart] ||= Hash.new(0)
    item = Item.find(params[:item_id])
    session[:cart][item.id.to_s] += 1
    flash[:success] = "#{item.name.capitalize} added to cart"
    redirect_back(fallback_location: root_path)
  end

end
