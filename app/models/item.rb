class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  # アクティブハッシュとのアソシエーション
  belongs_to :category
  belongs_to :region
  belongs_to :item_condition
  belongs_to :delivery_price
  belongs_to :delivery_time

  # active_storageアソシエーション
  has_one_attached :image

  # 空の投稿は保存できないようにする
  validates :image, presence: true
  validates :item_name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :item_condition_id, presence: true
  validates :delivery_price_id, presence: true
  validates :region_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 0 }
  validates :item_condition_id, numericality: { other_than: 0 }
  validates :delivery_price_id, numericality: { other_than: 0 }
  validates :region_id, numericality: { other_than: 0 }
  validates :delivery_time_id, numericality: { other_than: 0 }
end
