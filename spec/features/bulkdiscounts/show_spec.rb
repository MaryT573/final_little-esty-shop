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

  it 'can update whole discount' do
    merchant = Merchant.create!(name: "Wizards Chest")
    discount = merchant.bulkdiscounts.create!(discount: 0.2, threshold: 4)

    visit "/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}"

    expect(page).to have_content("Threshold: 4")
    expect(page).to have_content("20.0%")

    expect(page).to have_link("Update Discount")

    click_link("Update Discount")
    expect(current_path).to eq("/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}/edit")

    fill_in 'threshold', with: 5
    fill_in 'discount', with: 0.4
    click_on 'Update Discount'

    expect(current_path).to eq("/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}")

    expect(page).to have_content("Threshold: 5")
    expect(page).to have_content("40.0%")

    expect(page).to_not have_content("Threshold: 4")
    expect(page).to_not have_content("20.0%")
  end

  xit 'can update partial discount' do
    merchant = Merchant.create!(name: "Wizards Chest")
    discount = merchant.bulkdiscounts.create!(discount: 0.2, threshold: 4)

    visit "/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}"

    expect(page).to have_content("20.0%")
    expect(page).to have_content("Threshold: 4")

    click_link("Update Discount")
    expect(current_path).to eq("/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}/edit")

    fill_in 'discount', with: 0.4
    click_on 'Update Discount'

    expect(current_path).to eq("/merchants/#{merchant.id}/bulkdiscounts/#{discount.id}")

    expect(page).to have_content("Threshold: 4")
    expect(page).to have_content("40.0%")
    expect(page).to_not have_content("20.0%")
  end
end
