class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :telephone_number, :price).merge(user_id: current_user.id)
  end

  # def address_params
  #   params.permit(:post_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :telephone_number).merge(order_id: @order.id)
  # end
end
