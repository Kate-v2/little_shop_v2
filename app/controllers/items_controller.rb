require 'pry'

class ItemsController < ApplicationController

  def new
    #This is a dummy merchant. The code below will need to be replaced
    #if you do not have a user in your DB this will break
    @merchant = User.first
    @item = Item.new
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id)
  end

end
