class Order

  def initialize(data, customer)
    @customer = customer
    @contents = data
    invoices
    invoice_items
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def item_list
    Item.where(id: @contents.keys)
  end

  def invoices
    item_list.map do |item|
      Invoice.find_by(customer: @customer, merchant: item.merchant) ||
      Invoice.create(customer: @customer, merchant: item.merchant, status: 1)
    end.uniq
  end

  def invoice_items
    item_list.map do |item|
      invoice = Invoice.find_by(customer: @customer, merchant: item.merchant)
      InvoiceItem.create(quantity: count_of(item.id), unit_price: item.unit_price, status: 0, item: item, invoice: invoice)
    end
  end
end
