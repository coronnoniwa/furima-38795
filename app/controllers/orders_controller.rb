class OrdersController < ApplicationController
  def index
    @oder_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    binding.pry
  end
end
