# frozen_string_literal: true

class Merchants::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  after_action :check_concurrent_session, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    set_login_token
  end

  # DELETE /resource/sign_out
  def destroy
    super
    session.delete(:merchant)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def set_login_token
    token = Devise.friendly_token
    session[:merchant] = token
    current_merchant.login_token = token
    current_merchant.save
  end
end
