require 'rails_helper'

RSpec.describe 'merchant new bulk discount', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      @user = create(:user, role: 0)
      @merchant = create(:merchant, user: @user)
      login_as(@user, scope: :user)
    end

    it 'i can create new bulk discounts' do
      visit merchant_dashboard_index_path(@merchant)

      click_on 'Discounts'

      expect(@merchant.bulk_discounts).to be_empty
      
      click_on 'Create New Discount'
      
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      
      fill_in 'bulk_discount[pct_discount]', with: '10'
      fill_in 'bulk_discount[min_qty]', with: '50'
      click_on 'Create Discount'
      
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))

      expect(page).to have_content("Bulk discount was added successfully.")
      
      expect(@merchant.bulk_discounts).not_to be_empty
      
      new_discount = @merchant.bulk_discounts.first
      
      expect(page).to have_content(new_discount.id)
      expect(page).to have_content(new_discount.pct_discount)
      expect(new_discount.pct_discount).to eq(10)
      expect(page).to have_content(new_discount.min_qty)
      expect(new_discount.min_qty).to eq(50)
    end

    it 'sad path: min_qty validation fails and displays flash msgs' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'bulk_discount[pct_discount]', with: '50'
      fill_in 'bulk_discount[min_qty]', with: '1'
      click_on 'Create Discount'

      expect(page).to have_content('Min qty must be greater than 1')
      expect(@merchant.bulk_discounts).to be_empty
    end

    it 'sad path: pct_discount validates cannot be negative and displays flash msgs' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'bulk_discount[pct_discount]', with: '-10'
      fill_in 'bulk_discount[min_qty]', with: '10'
      click_on 'Create Discount'

      expect(page).to have_content('Pct discount must be greater than or equal to 5')
      expect(@merchant.bulk_discounts).to be_empty
    end

    it 'sad path: pct_discount validates integer and displays flash msgs' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'bulk_discount[pct_discount]', with: '10.5'
      fill_in 'bulk_discount[min_qty]', with: '25'
      click_on 'Create Discount'

      expect(page).to have_content('Pct discount must be an integer')
      expect(@merchant.bulk_discounts).to be_empty
    end

    it 'sad path: pct_discount cannot exceed 100% and displays flash msgs' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'bulk_discount[pct_discount]', with: '100'
      fill_in 'bulk_discount[min_qty]', with: '10'
      click_on 'Create Discount'

      expect(page).to have_content('Pct discount must be less than 100')
      expect(@merchant.bulk_discounts).to be_empty
    end

    it 'sad path: validates min qty >= 5 and min qt > 1, and renders multiple errors' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'bulk_discount[pct_discount]', with: '3'
      fill_in 'bulk_discount[min_qty]', with: '1'
      click_on 'Create Discount'

      expect(page).to have_content('Pct discount must be greater than or equal to 5')
      expect(page).to have_content('Min qty must be greater than 1')
      expect(@merchant.bulk_discounts).to be_empty
    end
  end
end