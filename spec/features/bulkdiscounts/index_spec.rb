require 'rails_helper'

RSpec.describe 'Bulkdiscount index' do
  it 'shows all discounts' do
    merchant1 = Merchant.create!(name: "Wizards Chest")
    merchant2 = Merchant.create!(name: "REI")
    discount1 = merchant1.bulkdiscounts.create!(discount: 0.2, threshold: 4)
    discount2 = merchant1.bulkdiscounts.create!(discount: 0.6, threshold: 5)
    discount3 = merchant2.bulkdiscounts.create!(discount: 0.7, threshold: 7)

    visit "/merchants/#{merchant1.id}/bulkdiscounts"
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts")

    expect(page).to_not have_content(discount3.threshold)
    expect(page).to_not have_content(discount3.id)

    within "#discounts-#{discount1.id}" do
      expect(page).to have_content(discount1.threshold)
      expect(page).to have_content(discount1.id)
      expect(page).to have_content("20%")
    end

    within "#discounts-#{discount2.id}" do
      expect(page).to have_content(discount2.threshold)
      expect(page).to have_content(discount2.id)
      expect(page).to have_content("60%")
    end
  end

  it 'links to show page' do
    merchant1 = Merchant.create!(name: "Wizards Chest")
    discount = merchant1.bulkdiscounts.create!(discount: 0.2, threshold: 4)

    visit "/merchants/#{merchant1.id}/bulkdiscounts"

    within "#discounts-#{discount.id}" do
      expect(page).to have_link("View Discount")

      click_link("View Discount")

      expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts/#{discount.id}")
    end
  end
end
