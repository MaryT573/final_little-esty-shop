class AddMerchantsToBulkdiscounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :bulkdiscounts, :merchant, foreign_key: true
  end
end
