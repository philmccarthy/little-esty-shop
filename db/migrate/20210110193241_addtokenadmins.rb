class Addtokenadmins < ActiveRecord::Migration[5.2]
  def self.up
    change_table 'admins' do |t|
      t.string "login_token"
    end
  end

  def self.down
    change_table 'admins' do |t|
      t.remove "login_token"
    end
  end
end
