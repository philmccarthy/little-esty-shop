require 'rails_helper'

RSpec.describe 'merchant bulk discounts index', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      @user = create(:user, role: 0)
      @merchant = create(:merchant, user: @user)
      @discount_1 = create(:bulk_discount, merchant: @merchant)
      @discount_2 = create(:bulk_discount, merchant: @merchant)
      @discount_3 = create(:bulk_discount, merchant: @merchant)

      login_as(@user, scope: :user)
    end

    it 'i see my bulk discounts listed and they link to show pages' do
      visit merchant_dashboard_index_path(@merchant)

      click_on 'Discounts'

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))

      expect(page).to have_link('Create New Discount')

      expect(page).to have_link("##{@discount_1.id}")
      expect(page).to have_content(@discount_1.min_qty)
      expect(page).to have_content("#{@discount_1.pct_discount}%")

      expect(page).to have_link("##{@discount_2.id}")
      expect(page).to have_content(@discount_2.min_qty)
      expect(page).to have_content("#{@discount_2.pct_discount}%")
      
      expect(page).to have_link("##{@discount_3.id}")
      expect(page).to have_content(@discount_3.min_qty)
      expect(page).to have_content("#{@discount_3.pct_discount}%")
    end

    it 'i can delete bulk discounts' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_content(@discount_1.id)
      expect(page).to have_content(@discount_2.id)
      expect(page).to have_content(@discount_3.id)
      expect(@merchant.bulk_discounts.size).to eq(3)

      within("#discount-#{@discount_1.id}") do
        click_on 'Delete'
      end
      expect(page).to have_content("Bulk discount was deleted successfully.")
      expect(@merchant.bulk_discounts.size).to eq(2)
      
      within("#discount-#{@discount_2.id}") do
        click_on 'Delete'
      end
      
      expect(page).to_not have_content(@discount_2.id)
      expect(page).to have_content("Bulk discount was deleted successfully.")
      expect(@merchant.bulk_discounts.size).to eq(1)
      
      within("#discount-#{@discount_3.id}") do
        click_on 'Delete'
      end
      
      expect(page).to_not have_content(@discount_3.id)
      expect(page).to have_content("Bulk discount was deleted successfully.")
      expect(@merchant.bulk_discounts.size).to eq(0)
    end

    it 'i see a button to view the edit page for each bulk discount' do
      visit merchant_bulk_discounts_path(@merchant)
      
      within("#discount-#{@discount_1.id}") do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
      
      visit merchant_bulk_discounts_path(@merchant)
      
      within("#discount-#{@discount_2.id}") do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_2))
      
      visit merchant_bulk_discounts_path(@merchant)

      within("#discount-#{@discount_3.id}") do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_3))
    end
  end
end
