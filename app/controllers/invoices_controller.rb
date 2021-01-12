class InvoicesController < ApplicationController
  before_action :correct_user?
  skip_before_action only: [:create]

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @item_list = Item.where(id: cart.contents.keys)
    @customer = current_customer
    @item_list.each do |item|
      item.merchant
      item.name
      item.unit_price
      quantity = cart.count_of(item.id)
      if Invoice.where(customer: @customer, merchant: item.merchant)
        InvoiceItem.create!(quantity: quantity, unit_price: item.unit_price, status: 0, item_id: item.id, invoice_id: invoice.id)
      else
        invoice = Invoice.create!(customer: @customer, merchant: item.merchant)
        InvoiceItem.create!(quantity: quantity, unit_price: item.unit_price, status: 0, item_id: item.id, invoice_id: invoice.id)
      end
      binding.pry
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
