class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    item = Item.find(params[:id])
    session[:cart] = cart.contents
    cart.add_item(item.id)
    quantity = cart.count_of(item)
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    binding.pry
    redirect_to "/"
  end
end
