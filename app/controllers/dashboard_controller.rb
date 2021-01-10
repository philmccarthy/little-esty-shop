class DashboardController < ApplicationController
  before_action :correct_user?

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
end
