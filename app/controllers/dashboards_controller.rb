class DashboardsController < ApplicationController

  before_action :require_role

  def index
    index_experience
    if @admin_experience
      @user = User.find(params[:id])
      redirect_to user_path if  @user.role == 'default'
    end
    @user = current_user if (@merch_experience || @admin_dashboard)
    @merchant_orders = @user.find_merchant_order_ids if (@merch_experience || @admin_experience)
  end

  def show
    @user  = current_user
    @items = @user.items
  end

  def new
    @merchant = User.find(session[:user_id])
    @item     = Item.new
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

  def index_experience
    path = request.path
    @merch_experience = (current_merchant? && path == dashboard_path)
    @admin_dashboard  = (current_admin?    && path == dashboard_path)
    @admin_experience = (current_admin?    && path == merchant_show_path) if params[:id]
    found = (
      @merch_experience ||
      @admin_dashboard  ||
      @admin_experience
    )
    found || not_found
  end

end
