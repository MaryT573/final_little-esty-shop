class BulkdiscountsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    @discounts = @merchant.bulkdiscounts
  end

  def show
    @discount = Bulkdiscount.find(params[:id])
  end
end
