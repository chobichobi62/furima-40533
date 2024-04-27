class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_owner, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])
    render 'orders/index'
  end

  def create
    @order_form = OrderForm.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_form.valid?
      pay_item
    @order_form.save
    redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postcode, :region_id, :city, :street_address, :build_address, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def redirect_if_owner
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def redirect_if_sold_out
      @item = Item.find(params[:item_id])
      if @item.order.present?
        redirect_to root_path
      end
  end
end
