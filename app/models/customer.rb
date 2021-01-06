class Customer < ApplicationRecord
  has_many :invoices

  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_five_customers
   joins(:transactions)
   .select("customers.*, count('transactions.result') AS transaction_count")
   .group(:id)
   .where('transactions.result = ?', 1)
   .order(transaction_count: :desc)
   .limit(5)
  end
  
end