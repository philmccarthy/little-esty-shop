class ApplicationController < ActionController::Base
  # before_action :check_concurrent_session
  helper_method :cart
  before_action :set_locale
  # Setting as before_action vs around_action due to before_action being thread-safe

  def cart
    cart ||= Cart.new(session[:cart])
  end

  # def correct_user?
  #   @merchant = Merchant.find(params[:merchant_id])
  #   render file: "/public/404" unless current_admin || @merchant.user_id == current_user.id
  # end
  #
  # def check_concurrent_session
  #   if admin_already_logged_in?
  #     flash[:notice] = "already signed in"
  #     sign_out(current_user)
  #     redirect_to(admin_merchants_url)
  #   end
  # end
  #
  # def admin_already_logged_in?
  #   current_user && !(session[:token] == current_user.login_token) ||
  #   current_admin && !(session[:token] == current_admin.login_token)
  # end
  #
  # def authorize_admin
  #   return unless !current_user.admin?
  #   redirect_to root_path, alert: 'Admins only!'
  # end
  private
  def set_locale
    I18n.locale = params[:lang] || locale_from_header || I18n.default_locale
  end

  # Grabbing weighted value of language from user browser
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end

  def default_url_options(options = {})
    {lang: I18n.locale}
  end
end
