class Merchant::InvoicesController < Merchant::BaseController
  skip_before_action only: [:create]

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
