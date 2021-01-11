require 'rails_helper'

RSpec.describe Cart do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    create(:customer)
  end
  subject { Cart.new({ @item => 2, @item2 => 3 }) }

  describe '#total_count' do
    it 'can calculate the total number of items it holds' do
      cart = Cart.new({ @item => 2, @item2 => 3 })

      expect(cart.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'adds an item to its contents' do
      cart = Cart.new({ @item => 2, @item2 => 3 })
      subject.add_item(@item)
      subject.add_item(@item2)

      expect(subject.contents).to eq({@item => 3, @item2 =>4})
    end
  end

  describe '#count_of' do
    it 'returns count of all items in cart' do
      cart = Cart.new({})

      expect(cart.count_of(5)).to eq(0)
    end
  end

end
