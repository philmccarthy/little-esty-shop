require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
    it {should have_one(:merchant).through(:item)}
    it {should have_many(:transactions).through(:invoice)}
  end

  describe 'methods' do
    before(:each) do
      @user = create(:user, role: 1)
      @merchant = create(:merchant, user: @user)
      create(:bulk_discount, pct_discount: 10, min_qty: 50, merchant: @merchant)
      create(:bulk_discount, pct_discount: 20, min_qty: 101, merchant: @merchant)
      create(:bulk_discount, pct_discount: 5, min_qty: 20, merchant: @merchant)
      
      @user1 = create(:user, role: 1)
      @customer_1 = create(:customer, user: @user1)
      @item = create(:item, merchant: @merchant)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-01-25 09:54:09")
      
      @inv_item_1 = create(:invoice_item, item: @item, unit_price: 25, quantity: 100, invoice: @invoice_1, status: 1)
      @inv_item_2 = create(:invoice_item, item: @item, unit_price: 25, quantity: 100, invoice: @invoice_1, status: 1)
    end

    describe 'class methods' do 
      it '::find_max_discount' do
        inv_item = InvoiceItem.find_max_discount(@inv_item_1.id)
        expect(inv_item.discount).to eq(10)
        expect(inv_item.unit_price).to eq(22.5)
      end
    end

    describe 'instance methods' do
      xit '#apply_max_discount' do

      end
    end
  end
end
