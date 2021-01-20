require 'rails_helper'

RSpec.describe 'merchant bulk discount show page', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      @user = create(:user, role: 0)
      @merchant = create(:merchant, user: @user)
      @discount_1 = create(:bulk_discount, merchant: @merchant)
      @discount_2 = create(:bulk_discount, merchant: @merchant)
      @discount_3 = create(:bulk_discount, merchant: @merchant)

      login_as(@user, scope: :user)
    end

    it 'when i visit the show page of one of my discounts i see min_qty and pct_discount' do
      visit merchant_bulk_discount_path(@merchant, @discount_1)
      
      expect(page).to have_content(@discount_1.id)
      expect(page).to have_content(@discount_1.min_qty)
      expect(page).to have_content(@discount_1.pct_discount)
    end
    
    it 'when i visit the bulk discount show page i see a link to edit it and i can edit the discount' do
      visit merchant_bulk_discount_path(@merchant, @discount_1)

      expect(page).to_not have_content('60')
      expect(page).to_not have_content('200')

      click_on 'Edit Discount'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))

      fill_in 'bulk_discount[pct_discount]', with: '60'
      fill_in 'bulk_discount[min_qty]', with: '200'
      click_on 'Save Changes'
      
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      expect(page).to have_content('60')
      expect(page).to have_content('200')
    end
  end
end
