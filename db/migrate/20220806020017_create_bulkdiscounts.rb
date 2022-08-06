class CreateBulkdiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulkdiscounts do |t|
      t.float :discount
      t.integer :threshold

      t.timestamps
    end
  end
end
