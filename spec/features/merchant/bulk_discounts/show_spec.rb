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
  end
end
