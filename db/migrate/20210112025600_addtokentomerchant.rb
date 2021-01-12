class Addtokentomerchant < ActiveRecord::Migration[5.2]
  def self.up
    change_table 'merchants' do |t|
      t.string "login_token"
    end
  end

  def self.down
    change_table 'merchants' do |t|
      t.remove "login_token"
    end
  end
end
