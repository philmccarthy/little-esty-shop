require 'rails_helper'

RSpec.describe 'merchant bulk discount edit page', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      @user = create(:user, role: 0)
      @merchant = create(:merchant, user: @user)
      @discount_1 = create(:bulk_discount, pct_discount: 20, min_qty: 150, merchant: @merchant)
      @discount_2 = create(:bulk_discount, pct_discount: 40, min_qty: 200, merchant: @merchant)

      login_as(@user, scope: :user)
    end

    it 'when i visit an edit page current attributes are prepopulated' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)
      
      expect(find_field('bulk_discount[pct_discount]').value).to eq("#{@discount_1.pct_discount}")
      expect(find_field('bulk_discount[min_qty]').value).to eq("#{@discount_1.min_qty}")
    end
    
    it 'sad paths throw errors' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)
      
      fill_in 'bulk_discount[pct_discount]', with: '100'
      fill_in 'bulk_discount[min_qty]', with: '1'
      click_on 'Save Changes'
      
      expect(page).to have_content('Pct discount must be less than 100')
      expect(page).to have_content('Min qty must be greater than 1')
      
      fill_in 'bulk_discount[pct_discount]', with: '20'
      fill_in 'bulk_discount[min_qty]', with: '0'
      click_on 'Save Changes'
      
      expect(page).to have_content('Min qty must be greater than 1')
      
      fill_in 'bulk_discount[pct_discount]', with: '-25'
      fill_in 'bulk_discount[min_qty]', with: '50'
      click_on 'Save Changes'
      
      expect(page).to have_content('Pct discount must be greater than or equal to 5')
      
      fill_in 'bulk_discount[pct_discount]', with: '4.99'
      click_on 'Save Changes'
      
      expect(page).to have_content('Pct discount must be an integer')
    end
    
    it 'can submit valid changes' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      fill_in 'bulk_discount[pct_discount]', with: '10'
      fill_in 'bulk_discount[min_qty]', with: '100'
      click_on 'Save Changes'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
      expect(page).to have_content('10')
      expect(page).to have_content('100')
    end
  end
end