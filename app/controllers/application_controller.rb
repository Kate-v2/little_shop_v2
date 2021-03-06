class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user
  helper_method :current_admin?
  helper_method :current_merchant?
  def current_user
    @current_user ||= User.find(session[:user_id].to_i) if session[:user_id]
  end

  before_action :set_cart

  def set_cart
    session[:cart] ||= Hash.new(0)
    @cart ||= Cart.new(session[:cart])
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
