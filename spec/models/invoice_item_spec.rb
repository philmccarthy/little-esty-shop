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
      @discount_1 = create(:bulk_discount, pct_discount: 10, min_qty: 50, merchant: @merchant)
      @discount_2 = create(:bulk_discount, pct_discount: 20, min_qty: 101, merchant: @merchant)
      @discount_3 = create(:bulk_discount, pct_discount: 5, min_qty: 20, merchant: @merchant)
      
      @user1 = create(:user, role: 1)
      @customer_1 = create(:customer, user: @user1)
      @item = create(:item, merchant: @merchant)
      @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant, status: 0, created_at: "2012-01-25 09:54:09")
      
      @inv_item_1 = create(:invoice_item, item: @item, unit_price: 25, quantity: 100, invoice: @invoice_1, status: 1)
      @inv_item_2 = create(:invoice_item, item: @item, unit_price: 25, quantity: 110, invoice: @invoice_1, status: 1)
    end

    describe 'class methods' do 
      it '::find_max_discount' do
        inv_item_1 = InvoiceItem.find_max_discount(@inv_item_1.id)
        expect(inv_item_1.discount).to eq(10)
        
        inv_item_2 = InvoiceItem.find_max_discount(@inv_item_2.id)
        expect(inv_item_2.discount).to eq(20)
      end
    end
    
    describe 'instance methods' do
      it '#apply_max_discount' do
        inv_item_1 = InvoiceItem.find_max_discount(@inv_item_1.id)
        inv_item_1.apply_max_discount
        expect(inv_item_1.unit_price).to eq(22.5)
        
        inv_item_2 = InvoiceItem.find_max_discount(@inv_item_2.id)
        inv_item_2.apply_max_discount

        expect(inv_item_2.unit_price).to eq(20)
      end
      
      it '#discounted?' do
        inv_item_1 = InvoiceItem.find(@inv_item_1.id)
        inv_item_2 = InvoiceItem.find(@inv_item_2.id)

        expect(inv_item_1.discounted?).to be_truthy
        expect(inv_item_2.discounted?).to be_truthy
      end

      it '#with_discount' do
        inv_item = @inv_item_1.with_discount
        expect(inv_item.discount).to eq(10)
        expect(inv_item.discount_applied).to eq(@discount_1.id)

        inv_item_2 = @inv_item_2.with_discount
        expect(inv_item_2.discount).to eq(20)
        expect(inv_item_2.discount_applied).to eq(@discount_2.id)
      end
    end
  end
end
