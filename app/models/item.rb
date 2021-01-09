class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, presence: true, format: { with: /\A\d{0,11}(\.?\d{0,2})?\z/ }, numericality: true
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  enum status: [ :disabled, :enabled ]
end
