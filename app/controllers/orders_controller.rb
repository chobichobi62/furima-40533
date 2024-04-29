class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :redirect_if_owner, :redirect_if_sold_out]
  before_action :redirect_if_owner, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
    render 'orders/index'
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new(order_params)
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
    params.require(:order_form).permit(:postcode, :region_id, :city, :street_address, :build_address, :phone_number).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def redirect_if_owner
    return unless current_user.id == @item.user_id
    redirect_to root_path
  end

  def redirect_if_sold_out
    return unless @item.order.present?
    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
