class InvoicesController < ApplicationController
  before_action :correct_user?

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @invoice = Invoice.find(params[:id])
  end

  private 

  def correct_user?
    @merchant = Merchant.find(params[:merchant_id])
    render file: "/public/404" unless @merchant.user_id == current_user.id || current_user.admin?
  end

end
