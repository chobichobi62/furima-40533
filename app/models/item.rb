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
  validates :user_id, presence: true
  validates :image, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :item_condition_id, presence: true
  validates :delivery_price_id, presence: true
  validates :region_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true

#ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :item_condition_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :delivery_price_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :region_id,numericality: { other_than: 1, message: "can't be blank"} 
  validates :delivery_time_id,numericality: { other_than: 1, message: "can't be blank"} 

end