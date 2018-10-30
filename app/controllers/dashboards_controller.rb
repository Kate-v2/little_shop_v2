class DashboardsController < ApplicationController

  before_action :require_role

  def index
    @user = current_user
  end

  def show
    @items = current_user.items
  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

end
