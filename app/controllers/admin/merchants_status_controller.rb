class Admin::MerchantsStatusController < Admin::BaseController
  before_action :set_merchant, only: [:update]

  def update
    @merchant.update(merchant_params)
    flash.notice = "#{@merchant.name}'s status was updated successfully!"
    redirect_to admin_merchants_path
  end

  private

  def admin_only
    render file: "/public/404" unless current_user.admin?
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:status)
  end
end
