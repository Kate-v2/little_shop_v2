class ItemsController < ApplicationController

  def new
    if current_user.admin?
      @merchant = User.find(params[:id])
    else
      @merchant = current_user
    end
    @item = Item.new
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.new(item_params)
    if item.save
      flash[:success] = "#{item.name.capitalize} added to store"
      if current_user.admin?
        redirect_to merchant_items_path(params[:user_id])
      else
        redirect_to dashboard_items_path
      end
    else
      flash[:error] = "#{item.name.capitalize}'s' information was invalid"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @items = Item.all
  end

  def show
    @items = [Item.find(params[:id])]
  end

  def edit
   @item = Item.find(params[:id])
   @merchant = current_user
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "You have successfully updated your info"
      redirect_to item_path(item)
    else
      flash[:notice] = "Please double check your info and try again"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id, :merch_id)
  end

end
