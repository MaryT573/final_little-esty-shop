require 'rails_helper'

RSpec.describe 'Bulkdiscount index' do
  it 'shows all discounts' do
    merchant1 = Merchant.create!(name: "Wizards Chest")
    discount1 = merchant1.bulkdiscounts.create!(discount: 0.2, threshold: 4)
    discount2 = merchant1.bulkdiscounts.create!(discount: 0.6, threshold: 5)

    visit "/merchants/#{merchant1.id}/bulkdiscounts"
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts")

    within "#discounts-#{discount1.id}" do
      expect(page).to have_content(discount1.threshold)
      expect(page).to have_content(discount1.id)
      expect(page).to have_content("20.0%")
    end

    within "#discounts-#{discount2.id}" do
      expect(page).to have_content(discount2.threshold)
      expect(page).to have_content(discount2.id)
      expect(page).to have_content("60.0%")
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

  it "can create new discount" do
    merchant1 = Merchant.create!(name: "Wizards Chest")

    visit "/merchants/#{merchant1.id}/bulkdiscounts"
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts")

    expect(page).to_not have_content("Threshold: 5")
    expect(page).to_not have_content("20.0%")

    expect(page).to have_link("Create Discount")
    click_link("Create Discount")
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts/new")

    fill_in 'threshold', with: 5
    fill_in 'discount', with: 0.2
    click_on 'Create Discount'

    visit "/merchants/#{merchant1.id}/bulkdiscounts"

    expect(page).to have_content("Threshold: 5")
    expect(page).to have_content("20.0%")
  end

  it 'can reject whole numbers' do
    merchant1 = Merchant.create!(name: "Wizards Chest")

    visit "/merchants/#{merchant1.id}/bulkdiscounts"

    click_link("Create Discount")
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts/new")

    fill_in 'threshold', with: 5
    fill_in 'discount', with: 2
    click_on 'Create Discount'

    expect(page).to have_content("Can only accept numbers below 1")
    expect(current_path).to eq("/merchants/#{merchant1.id}/bulkdiscounts/new")
  end
end
