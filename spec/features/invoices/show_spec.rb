require 'rails_helper'

RSpec.describe 'Invoice Show', type: :feature do
  it 'shows the invoice' do
    merchant_1 = Merchant.create!(id: 1, name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    item_1 = merchant_1.items.create!(id: 1, merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
    item_2 = merchant_1.items.create!(id: 2, merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

    customer_1 = Customer.create!(id: 1, first_name: "John", last_name: "Doe", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

    invoice_1 = customer_1.invoices.create!(id: 10, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)
    invoice_2 = customer_1.invoices.create!(id: 11, status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)

    invoice_item_1 = InvoiceItem.create!(id: 1, item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
    invoice_item_2 = InvoiceItem.create!(id: 2, item_id: item_2.id, invoice_id: invoice_2.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")

    visit '/merchants/1/invoices/10'

    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("#{invoice_1.status}")
    expect(page).to have_content("#{invoice_1.created_at}")
    expect(page).to have_content("#{invoice_1.customer.first_name}")
    expect(page).to have_content("#{invoice_1.customer.last_name}")
  end
end