class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price, numericality: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: [ :disabled, :enabled ]

  def best_day
    invoices.select('invoices.created_at AS created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('invoices.created_at')
    .max
    .date
  end
end
