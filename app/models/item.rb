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

  #空の投稿は保存できないようにする
  validates :user_id
  validates :image
  validates :item_name
  validates :description
  validates :category_id
  validates :item_condition_id
  validates :delivery_price_id
  validates :region_id
  validates :delivery_time_id
  validates :price

#ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :item_condition_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :delivery_price_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :region_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :delivery_time_id,numericality: { other_than: 1, message: "can't be blank"} 
  
end