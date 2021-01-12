class Changemerchantsname < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :name
    add_column :merchants, :user_name, :string
  end
end
