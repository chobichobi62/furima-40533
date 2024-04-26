class OrdersController < ApplicationController
  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])
    render 'orders/index'
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.save
    redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postcode, :region_id, :city, :street_address, :build_address, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end

end