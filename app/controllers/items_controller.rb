class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :item_condition_id, :delivery_price_id, :region_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end
