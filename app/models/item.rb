class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  #アクティブハッシュとのアソシエーション
  belongs_to :category
  belongs_to :region
  belongs_to :item_condition
  belongs_to :delivery_price
  belongs_to :delivery_time

  #active_storageアソシエーション
  has_one_attached :image

end