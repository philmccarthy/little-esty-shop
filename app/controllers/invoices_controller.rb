class InvoicesController < ApplicationController
  before_action :correct_user?

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
