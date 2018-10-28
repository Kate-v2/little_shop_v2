class Dashboard::DashboardsController < ApplicationController

  before_action :require_role

  def index

  end

  private

  def require_role
    render file: "public/404" unless current_admin? || current_merchant?
  end

end
