class BulkdiscountsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    @discounts = @merchant.bulkdiscounts
  end

  def show
    @discount = Bulkdiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    if params[:discount] > "1"
      redirect_to "/merchants/#{merchant.id}/bulkdiscounts/new"
      flash[:alert] = "Can only accept numbers below 1"
    else
      merchant.bulkdiscounts.create(discount: params[:discount], threshold: params[:threshold])
      redirect_to "/merchants/#{merchant.id}/bulkdiscounts"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    Bulkdiscount.destroy(params[:id])
    redirect_to "/merchants/#{merchant.id}/bulkdiscounts"
  end
end
