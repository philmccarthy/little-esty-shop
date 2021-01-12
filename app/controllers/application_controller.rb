class ApplicationController < ActionController::Base
  before_action :check_concurrent_session
  helper_method :cart
  helper_method :order

  def order
    order ||= Order.new(session[:cart], current_customer)
  end

  def cart
    cart ||= Cart.new(session[:cart])
  end

  def correct_user?
    @merchant = Merchant.find(params[:merchant_id])
    render file: "/public/404" unless current_admin || @merchant.user_id == current_user.id
  end

  def check_concurrent_session
    if admin_already_logged_in?
      flash[:notice] = "already signed in"
      sign_out(current_user)
      redirect_to(admin_merchants_url)
    end
  end

  def admin_already_logged_in?
    current_user && !(session[:token] == current_user.login_token) ||
    current_admin && !(session[:token] == current_admin.login_token)
  end

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Admins only!'
  end
end
