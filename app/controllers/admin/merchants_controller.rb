class Admin::MerchantsController < Admin::BaseController
  before_action :set_merchant, only:[:show, :edit, :update]

  def index
    @merchants_enabled = Merchant.enabled
    @merchants_disabled = Merchant.disabled
    @top_5_merchants = Merchant.top_5_merchants
  end

  def new
    @merchant = Merchant.new
  end

  def edit
  end

  def show
  end

  def create
    user = User.create(user_params)
    user.merchant.new(merchant_params)
    if @merchant.save
      flash.notice = "Merchant #{@merchant.name} was created successfully!"
      redirect_to admin_merchants_path
    else
      flash[:error] = "Merchant was not created successfully!"
      render :new
    end
  end

  def update
    if @merchant.update(merchant_params)
      flash.notice = "Merchant #{@merchant.user_name} was updated successfully!"
      redirect_to admin_merchant_path(@merchant)
    else
      flash[:error] = @merchant.errors.full_messages
      set_merchant
      render :edit
    end
  end

  private

  def admin_only
    render file: "/public/404" unless current_user.admin?
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:user_name)
  end

  def user_params
    params.require(:merchant).permit(:user_name, :email, :password)
  end
end
