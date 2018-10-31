class DashboardsController < ApplicationController

  before_action :require_role

  def index
    if current_admin? && params[:id]
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
      @items = current_user.items
      @user = current_user
  end

  def new
    @merchant = User.find(session[:user_id])
    @item = Item.new
  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end


end
