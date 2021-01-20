class InvoiceItem < ApplicationRecord
  belongs_to :item
  has_one :merchant, through: :item
  belongs_to :invoice
  has_many :transactions, through: :invoice

  enum status: [ :pending, :packaged, :shipped ]

  after_save :apply_max_discount

  def apply_max_discount
    inv_item = self.with_discount
    if inv_item
      inv_item.update_columns(
        unit_price: (inv_item.unit_price * (1 - inv_item.discount.to_f / 100)),
        discount_applied: inv_item.discount_id
      )
    end
  end

  def with_discount
    InvoiceItem.find_max_discount(self.id)
  end

  def discounted?
    !discount_applied.nil?
  end

  def self.find_max_discount(id)
    joins(merchant: :bulk_discounts).
    select('invoice_items.*, bulk_discounts.pct_discount AS discount, bulk_discounts.id AS discount_id').
    where("invoice_items.id = ? AND invoice_items.quantity >= bulk_discounts.min_qty", id).
    order('bulk_discounts.pct_discount DESC').
    limit(1).first
  end
end
