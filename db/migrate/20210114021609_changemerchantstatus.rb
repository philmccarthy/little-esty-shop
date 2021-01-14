class Changemerchantstatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :status
    add_column :merchants, :status, :integer, default: 1
  end
end
