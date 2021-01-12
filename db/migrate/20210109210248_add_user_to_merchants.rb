class AddUserToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_reference :merchants, :user, foreign_key: true
    add_reference :customers, :user, foreign_key: true
  end
end
