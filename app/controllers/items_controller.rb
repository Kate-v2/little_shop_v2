class ItemsController < ApplicationController

  def new
    @merchant = User.find(session[:user_id])
    @item = Item.new
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
  end

  def index
    @items = Item.all
  end

  def show

  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id)
  end

end
