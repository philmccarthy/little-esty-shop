class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @order = Order.new(cart.contents, current_user.customer)
    @order.create_invoices
    binding.pry
    redirect_to customer_path(current_user.customer.id)
  end

  def show
    @invoices = @order.invoices
    @items = @order.items
  end
end
