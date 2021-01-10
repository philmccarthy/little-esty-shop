class MerchantItemsStatusController < ApplicationController
  before_action :set_item, only: [:update]
  before_action :set_merchant, only: [:update]
  before_action :correct_user?

  def update
    @item.update!(item_params)
    flash.notice = "#{@item.name}'s status was updated successfully!"
    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.require(:item).permit(:status)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def correct_user?
    @merchant = Merchant.find(params[:merchant_id])
    render file: "/public/404" unless @merchant.user_id == current_user.id || current_user.admin?
  end
end