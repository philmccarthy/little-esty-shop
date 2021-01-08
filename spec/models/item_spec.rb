require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'class methods' do
    it '#top_5_items' do
      @merchant_2 = create(:merchant)
      @customer_23 = create(:customer)
      @invoice_33 = create(:invoice, merchant: @merchant_2, customer: @customer_23)
      @invoice_43 = create(:invoice, merchant: @merchant_2, customer: @customer_23)
      create(:transaction, result: 1, invoice: @invoice_33)
      create(:transaction, result: 0, invoice: @invoice_43)

      create_list(:item, 6, merchant: @merchant_2)

      create(:invoice_item, item: @merchant_2.items.fourth, invoice: @invoice_33, quantity: 10, unit_price: 2)#60
      1.times do
        create(:invoice_item, item: @merchant_2.items.first, invoice: @invoice_33, quantity: 10, unit_price: 3)#30
      end

      3.times do
        create(:invoice_item, item: @merchant_2.items.second, invoice: @invoice_33, quantity: 10, unit_price: 4)#120
      end
        create(:invoice_item, item: @merchant_2.items.third, invoice: @invoice_33, quantity: 10, unit_price: 6)#60
        create(:invoice_item, item: @merchant_2.items.fifth, invoice: @invoice_33, quantity: 10, unit_price: 1)#60
      2.times do
        create(:invoice_item, item: @merchant_2.items.third, invoice: @invoice_43, quantity: 10, unit_price: 6)
      end

      expected = [@merchant_2.items.second, @merchant_2.items.third, @merchant_2.items.first, @merchant_2.items.fourth, @merchant_2.items.fifth]
      # actual = @merchant_2.top_5_items.map { | x | x[:name]}
      expect(@merchant_2.items.top_5_items).to eq(expected)
    end
  end

  describe 'instance methods' do
    it '#best day' do
      @merchant_2 = create(:merchant)
      @customer_23 = create(:customer)
      @invoice_33 = create(:invoice, merchant: @merchant_2, customer: @customer_23)
      @invoice_43 = create(:invoice, merchant: @merchant_2, customer: @customer_23)
      create(:transaction, result: 1, invoice: @invoice_33)
      create(:transaction, result: 0, invoice: @invoice_43)

      create_list(:item, 6, merchant: @merchant_2)

      create(:invoice_item, item: @merchant_2.items.fourth, invoice: @invoice_33, quantity: 10, unit_price: 2)#60
      1.times do
        create(:invoice_item, item: @merchant_2.items.first, invoice: @invoice_33, quantity: 10, unit_price: 3)#30
      end

      3.times do
        create(:invoice_item, item: @merchant_2.items.second, invoice: @invoice_33, quantity: 10, unit_price: 4)#120
      end
        create(:invoice_item, item: @merchant_2.items.third, invoice: @invoice_33, quantity: 10, unit_price: 6)#60
        create(:invoice_item, item: @merchant_2.items.fifth, invoice: @invoice_33, quantity: 10, unit_price: 1)#60
      2.times do
        create(:invoice_item, item: @merchant_2.items.third, invoice: @invoice_43, quantity: 10, unit_price: 6)
      end

      expected = [@merchant_2.items.second, @merchant_2.items.third, @merchant_2.items.first, @merchant_2.items.fourth, @merchant_2.items.fifth]
      expect(@merchant_2.items.fourth.best_day).to eq(@invoice_33.date)
      expect(@merchant_2.items.top_5_items).to eq(expected)
    end
  end
end
