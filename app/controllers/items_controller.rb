class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_merchant
  
  def index
  end

  def show
  end

  def edit
  end
  
  def new
    @item = Item.new
  end

  def create
    @merchant.items.create(item_params)
    redirect_to merchant_items_path(params[:merchant_id])
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Item successfully updated"
      redirect_to merchant_item_path(@item.merchant_id, @item.id)
    else
      flash[:error] = @item.errors.full_messages
      set_item
      render :edit 
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
