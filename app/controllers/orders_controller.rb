class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])

    if current_user.id == @item.user_id or @item.order.present?
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :telephone_number).merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  # def address_params
  #   params.permit(:post_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :telephone_number).merge(order_id: @order.id)
  # end
end
