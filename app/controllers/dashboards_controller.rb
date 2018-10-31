class DashboardsController < ApplicationController

  before_action :require_role

  def index
    if current_admin? && request.path == '/dashboard'
      @user = current_user
      @merchant_orders = @user.find_merchant_order_ids
    elsif current_admin? && params[:id]
      if User.find(params[:id]).role == "default"
        redirect_to user_path
      else
        @user = User.find(params[:id])
        @merchant_orders = @user.find_merchant_order_ids
      end
    else
      @user = current_user
      @merchant_orders = @user.find_merchant_order_ids
    end
  end

  def show
    if current_admin?
      @user = User.find(params[:id])
      @items = @user.items
    else
      @user = current_user
      @items = @user.items
    end

  end

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


  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id)
  end

end
