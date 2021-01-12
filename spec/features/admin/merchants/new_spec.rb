require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'Admin Merchant Edit Page' do
    
    before :each do
      @admin = create(:admin)
      login_as(@admin, scope: :admin)
    end

    it 'can create a new merchant' do
      visit new_admin_merchant_path
      fill_in 'user[email]', with: 'test@gmail.com'
      fill_in 'user[password]', with: 'testpass'
      fill_in 'user[password_confirmation]', with: 'testpass'
      fill_in 'user[merchant]', with: 'merchant name'
      click_on 'Create'

      expect(page).to have_content("You have signed up successfully.")
    end

    it 'displays flash message if validations fail' do
      visit new_admin_merchant_path
      fill_in 'user[email]', with: 'test@gmail.com'
      fill_in 'user[password]', with: 'testpass'
      fill_in 'user[password_confirmation]', with: 'testpass'
      click_on 'Create'

      expect(page).to have_content("Error")
    end
  end
end