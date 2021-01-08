class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [:disabled, :enabled]

  def ready_to_ship
    first =  invoice_items
                     .joins(:item)
                     .select('items.id, items.name as item_name, invoices.id as invoice_id, invoices.created_at AS invoice_date')
                     .where.not('invoice_items.status = ?', 2)
                     .order('invoice_date')
  end

  def top_5
    transactions
      .joins(invoice: :customer)
      .select('customers.*, count(transactions) as total_success')
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .order('total_success DESC')
      .limit(5)
  end

  # changed association call to items and joins to transactions so the query returns items instead of transactions. 
  # Allows item.best_day to be called in the item index view
  def top_5_items
    items
    .joins(invoices: :transactions) 
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .where('transactions.result = ?', 1)
      .group('items.id')
      .order('total_revenue desc')
      .limit(5)
  end

  def best_day
    invoices
    .joins(:invoice_items)
    .select('invoices.created_at AS created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('invoices.created_at')
    .max
    .date
  end
end
