class ItemsController < ApplicationController

  before_action :require_role, except: [:index, :show]

  def new
    @merchant = User.find(session[:user_id])
    @item = Item.new
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.new(item_params)
    if item.save
      flash[:success] = "#{item.name.capitalize} added to store"
      redirect_to "/dashboard/items"
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
    if !params[:item]
      @item.toggle(:active).save
      if @item.active
        flash[:success] = "#{@item.name} is now for sale"
      else
        flash[:success] = "#{@item.name} no longer for sale"
      end
      redirect_back(fallback_location: root_path)
    else
      if @item.update(item_params)
        flash[:success] = "You have successfully updated your info"
        redirect_to item_path(@item)
      else
        flash[:notice] = "Please double check your info and try again"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id)
  end

end
