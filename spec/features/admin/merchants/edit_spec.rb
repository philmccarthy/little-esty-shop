require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  before :each do
    @user = create(:user, role: 1)
    @merchant_1 = create(:merchant, user: @user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  describe 'Admin Merchant Edit Page' do
    it 'can fill in the edit form' do
      visit edit_admin_merchant_path(@merchant_1)
      fill_in 'merchant[name]', with: 'Test'
      click_on 'Update Merchant'

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content('Test')
      expect(page).to have_content("Merchant Test was updated successfully!")
    end

    it 'displays flash message if validations fail' do
      visit edit_admin_merchant_path(@merchant_1)
      fill_in 'merchant[name]', with: ''
      click_on 'Update Merchant'

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content("[\"Name can't be blank\"]")
    end
  end
end