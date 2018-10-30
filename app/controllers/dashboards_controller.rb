class DashboardsController < ApplicationController

  before_action :require_role

  def index
    @user = current_user
  end

  def show
    @items = current_user.items
    @user = current_user
  end

  def new
    @merchant = User.find(session[:user_id])
    @item = Item.new
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :inventory, :user_id)
  end

end
