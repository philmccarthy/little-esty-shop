require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'Admin Merchant Edit Page' do
    
    before :each do
      @user = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can fill in the new form' do
      visit new_admin_merchant_path
      fill_in 'Name', with: 'Test'
      click_on 'Create Merchant'

      expect(current_path).to eq(admin_merchants_path(@merchant_1))
      expect(page).to have_content('Test')
    end

    it 'displays flash message if validations fail' do
      visit new_admin_merchant_path
      fill_in 'Name', with: ''
      click_on 'Create Merchant'

      expect(current_path).to eq(admin_merchants_path(@merchant_1))
      expect(page).to have_content("Merchant was not created successfully!")
    end
  end
end