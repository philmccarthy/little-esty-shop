class Merchant::BulkDiscountsController < Merchant::BaseController
  before_action :set_bulk_discount, except: [:index, :new, :create]
  before_action :set_merchant

  def index
  end

  def show
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.valid?
      @bulk_discount.save
      flash.notice = "Bulk discount was added successfully."
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:error] = @bulk_discount.errors.full_messages
      render :new
    end
  end

  def destroy
    @bulk_discount.destroy
    flash.notice = "Bulk discount was deleted successfully."
    redirect_to merchant_bulk_discounts_path(@merchant)
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