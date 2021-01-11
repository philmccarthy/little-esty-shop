require 'rails_helper'

RSpec.describe "When a user adds items to their cart" do
  it "displays a message" do
      @merchant = create(:merchant)
      @item = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)
      create(:customer)

    visit "/"

    within("#item-#{@item.id}") do
      click_button "Add Item"
    end

    within("#item-#{@item2.id}") do
      click_button "Add Item"
    end
    within("#item-#{@item.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("You now have 2 copies of #{@item.name} in your cart.")
    expect(page).to have_content("Cart: 3")
  end
end
