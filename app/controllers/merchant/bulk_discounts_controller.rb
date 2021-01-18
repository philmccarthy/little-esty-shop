class Merchant::BulkDiscountsController < Merchant::BaseController
  before_action :set_bulk_discount, except: [:index, :new, :create]
  before_action :set_merchant

  def index
  end

  def show
  end


  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:pct_discount, :min_qty)
  end

  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end