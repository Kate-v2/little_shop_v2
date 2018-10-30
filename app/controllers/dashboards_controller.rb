class DashboardsController < ApplicationController

  before_action :require_role

  def index
    @user = User.find(session[:user_id])
    @merchant_orders = @user.find_merchant_order_ids
  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

end
