class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @order = Order.new(cart.contents, current_customer)
    @order.create_invoices
    redirect_to customer_path
  end

  def show
    @invoices = @order.invoices
    @items = @order.items
  end
end
