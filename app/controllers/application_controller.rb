class ApplicationController < ActionController::Base
  before_action :check_concurrent_session

  def check_concurrent_session
    if admin_signed_in?
      flash[:notice] = "already signed in"
      sign_out(current_merchant)
      redirect_to(admin_merchants_url)
    end
  end

  def signed_in
    render file: "/public/404" unless merchant_signed_in? || admin_signed_in?
  end
end
