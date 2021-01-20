require 'rails_helper'

describe 'As an admin' do
  describe 'When i visit an admin invoice show apge' do
    before :each do
      @admin = create(:user, role: 1)
      @user1 = create(:user, role: 0)
      @user2 = create(:user, role: 0)

      @merchant = create(:merchant, user: @user1)

      @customer_1 = create(:customer, user: @user2)

      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0)

      @item = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)

      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice_1, status: 0)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice_1, status: 0)

      login_as(@admin, scope: :user)
    end

    it 'I see the invoices attributes' do
      visit admin_invoice_path(@invoice_1)

      within("#invoice-info") do
        expect(page).to have_content(@invoice_1.date)
        expect(page).to have_content(@invoice_1.total_revenue.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse)
      end
    end

    it 'I see the customer info pertaining to the invoice' do
      visit admin_invoice_path(@invoice_1)

      within("#customer-info") do
        expect(page).to have_content("#{@invoice_1.customer_name}")
        expect(page).to have_content("123 Drury Ln")
        expect(page).to have_content("Nowhere, ID 10001")
      end
    end

    it 'I can update the invoices status' do
      visit admin_invoice_path(@invoice_1)

      within("#update-status") do
        expect(page).to have_content("Cancelled")

        select("Completed", :from => "invoice[status]")

        click_button "Update Invoice"

        expect(page).to have_content("Completed")
      end

      expect(page).to have_content("Invoice successfully updated")
    end

    it 'I can see that total revenue includes discounts', :skip_before do
      Item.destroy_all
      @user = create(:user, role: 0)
      @merchant = create(:merchant, user: @user)

      @user4 = create(:user, role: 0)
      @customer_4 = create(:customer, user: @user4)
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4)

      create_list(:item, 3, merchant: @merchant)

      discount_1 = create(:bulk_discount, pct_discount: 10, min_qty: 10, merchant: @merchant)
      discount_2 = create(:bulk_discount, pct_discount: 20, min_qty: 20, merchant: @merchant)

      inv_item_1 = create(:invoice_item, item: Item.first, invoice: @invoice_7, quantity: 100, unit_price: 10.00, status: 1)
      inv_item_2 = create(:invoice_item, item: Item.second, invoice: @invoice_7, quantity: 10, unit_price: 20.00, status: 1)
      inv_item_3 = create(:invoice_item, item: Item.third, invoice: @invoice_7, quantity: 5, unit_price: 100.00, status: 1)

      inv_item_1 = InvoiceItem.find(inv_item_1.id)
      inv_item_2 = InvoiceItem.find(inv_item_2.id)
      inv_item_3 = InvoiceItem.find(inv_item_3.id)

      login_as(@admin, scope: :user)

      visit admin_invoice_path(@invoice_7)

      expect(page).to have_content("Total Revenue: $1,480.00")
      expect(@invoice_7.total_revenue).to eq(1480.00)

      within("#inv-item-#{inv_item_1.id}") do
        expect(page).to have_content(inv_item_1.unit_price)
        expect(page).to have_content("#{discount_2.pct_discount}% — (ref. ##{discount_2.id})")
      end

      within("#inv-item-#{inv_item_2.id}") do
        expect(page).to have_content(inv_item_2.unit_price)
        expect(page).to have_content("#{discount_1.pct_discount}% — (ref. ##{discount_1.id})")
      end

      within("#inv-item-#{inv_item_3.id}") do
        expect(page).to have_content(inv_item_3.unit_price)
        expect(page).to have_content("None")
      end
    end
  end
end
