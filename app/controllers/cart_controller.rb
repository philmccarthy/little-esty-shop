class CartController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :order

  def show
    @item_list = Item.where(id: cart.contents.keys)
    @customer = current_customer
  end

  def update
    item = Item.find(params[:id])
    session[:cart] = cart.contents
    cart.add_item(item.id)
    quantity = cart.count_of(item.id)
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    redirect_to "/"
  end
end
