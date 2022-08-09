class InvoicesController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :update]
  before_action :find_invoice, only: [:show, :update]
  before_action :find_invoice_item, only: [:update]

  def index
    @invoices = @merchant.invoices
  end

  def show
    @bulk = @merchant.bulkdiscounts
  end

  def update
    @invoice_item.update!(invoice_item_params)
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
