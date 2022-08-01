class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :edit, :show, :new]
  before_action :find_item, only: [:edit, :show, :update]


  def index
   
  end

  def show
    
  end

  def new
    
  end

  def create
    item = Item.new(name: params[:name], description: params[:description],unit_price: params[:unit_price], merchant_id: params[:id], status: 1)
    if item.save
      redirect_to merchant_items_path(item.merchant_id)
    else
      redirect_to "/merchants/#{item.merchant_id}/items/new" 
      flash[:alert] = "Error: #{error_message(item.errors)}" 
    end
  end

  def edit
   
  end

  def update
    if params[:status] == "enabled"
      @item.update(status: "enabled")
      redirect_to merchant_items_path(@item.merchant_id)
      flash[:alert] = "#{@item.name} has been enabled."
    elsif params[:status] == "disabled"
      @item.update(status: "disabled")
      redirect_to merchant_items_path(@item.merchant_id)
      flash[:alert] = "#{@item.name} has been disabled."
    elsif @item.update(item_params)
      redirect_to merchant_item_path(@item.merchant_id, @item.id)
      flash[:alert] = "Success: Item information successfully updated"
    else
      redirect_to "/merchants/#{@item.merchant_id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end