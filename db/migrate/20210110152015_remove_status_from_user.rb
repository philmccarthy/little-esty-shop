class RemoveStatusFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :status, :integer, default: 0
  end
end
