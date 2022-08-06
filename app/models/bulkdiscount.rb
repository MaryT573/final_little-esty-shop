class Bulkdiscount < ApplicationRecord
  validates :discount, presence: true
  validates :threshold, presence: true

  belongs_to :merchant
end
