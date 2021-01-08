class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  enum status: [ :disabled, :enabled ]


  def self.top_5_items
    joins(:transactions)
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where('transactions.result = ?', 1)
    .group('items.id')
    .order('total_revenue DESC')
    .limit(5)
  end
end
