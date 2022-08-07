require 'rails_helper'

RSpec.describe 'Bulkdiscount show' do
  it "shows quantity threshold and discount" do
    merchant = Merchant.create!(name: "Wizards Chest")
    discount = merchant.bulkdiscounts.create!(discount: 0.2, threshold: 4)

    visit "/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}"
    expect(current_path).to eq("/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}")

    expect(page).to have_content(discount.threshold)
    expect(page).to have_content(discount.id)
    expect(page).to have_content("20.0%")
  end
end
