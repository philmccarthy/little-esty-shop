class Updateinvitemstatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoice_items, :status
    add_column :invoice_items, :status, :integer, default: 0
  end
end
