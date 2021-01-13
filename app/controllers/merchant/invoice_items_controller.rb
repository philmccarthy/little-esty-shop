class Merchant::InvoiceItemsController < Merchant::BaseController
  before_action :set_item, only: [:update]
  before_action :authenticate_user!
  before_action do
    redirect_to new_user_session_path unless current_user && current_user.merchant?
  end

  def update
      @invoice_item.update!(item_params)
      flash[:success] = "Item successfully updated"
      redirect_to merchant_invoice_path(params[:merchant_id], @invoice_item.invoice_id)
  end

  private

  def item_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end

  def set_item
    @invoice_item = InvoiceItem.find(params[:id])
  end
end