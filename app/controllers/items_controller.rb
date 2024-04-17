class ItemsController < ApplicationController
  def index
  end

  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :item_condition_id, :delivery_price_id, :region_id, :delivery_time_id, :price).merge(user_id: current_user.id)
  end
end
