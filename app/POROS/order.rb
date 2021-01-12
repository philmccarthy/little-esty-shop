class Order
  attr_reader :invoices,
              :invoice_items

  def initialize(data, customer)
    @data = data
    @customer = customer
    @invoices = []
    @invoice_items = []
    @contents = data
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def create_invoices
    @item_list = Item.where(id: @contents.keys)
    @item_list.map do |item|
      quantity = count_of(item.id)
      if Invoice.find_by(customer: @customer, merchant: item.merchant)
         invoice = Invoice.find_by(customer: @customer, merchant: item.merchant)
        @invoice_items << InvoiceItem.create(quantity: quantity, unit_price: item.unit_price, status: 0, item: item, invoice: invoice)
      else
        @invoices << Invoice.create(customer: @customer, merchant: item.merchant, status: 1)
        @invoice_items << InvoiceItem.create(quantity: quantity, unit_price: item.unit_price, status: 0, item: item, invoice: @invoices.last)
      end
    end
  end
end
