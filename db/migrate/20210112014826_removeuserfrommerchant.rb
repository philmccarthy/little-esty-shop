class Removeuserfrommerchant < ActiveRecord::Migration[5.2]
  def change
    remove_reference :merchants, :user

  end
end
