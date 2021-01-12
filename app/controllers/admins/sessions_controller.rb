# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  skip_before_action :check_concurrent_session

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
    binding.pry
    session.delete(:token)
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def set_login_token
    token = Devise.friendly_token
    session[:token] = token
    current_admin.login_token = token
    current_admin.save
  end
end
