class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :customer_id, presence: true

  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2}

  def self.order_by_date
    order("created_at DESC")
  end


  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def discounted
    invoice_items.joins(merchants: :bulkdiscounts)
    .where('invoice_items.quantity >= bulkdiscounts.threshold')
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulkdiscounts.discount * 100.0)) as total_discount')
    .group('invoice_items.id')
    .sum(&:total_discount)
    #require "pry"; binding.pry
  end

  def self.find_with_merchant(merchant)
    merchant.invoices
  end

end
