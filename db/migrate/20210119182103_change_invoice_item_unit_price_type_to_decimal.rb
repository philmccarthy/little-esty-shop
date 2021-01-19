class ChangeInvoiceItemUnitPriceTypeToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :unit_price, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
