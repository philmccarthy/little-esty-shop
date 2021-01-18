class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :pct_discount, numericality: { only_integer: true, less_than: 100, greater_than_or_equal_to: 5 }
  validates :min_qty, numericality: { only_integer: true, greater_than: 1 }
end
