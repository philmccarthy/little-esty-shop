class Merchant::InvoicesController < Merchant::BaseController
  skip_before_action only: [:create]
  before_action :authenticate_user!
  before_action do
    redirect_to new_user_session_path unless current_user && current_user.merchant?
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
