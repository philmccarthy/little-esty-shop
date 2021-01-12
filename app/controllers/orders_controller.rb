class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @item_list = Item.where(id: cart.contents.keys)
    session[:order] = order.create_invoices
    render 'show'
  end

  def show
    @invoices = order.invoices
    @items = order.items
    binding.pry
  end
end
