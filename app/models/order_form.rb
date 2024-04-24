class OrderForm
  include ActiveModel::Model
  attr_accessor :attr_accessor :user_id, :item_id, :postcode, :region_id, :city, :street_adress, :build_adress, :phone_number

  with_options presence: true do
  #orderモデルバリデーション
  validates :user_id
  validates :item_id
  #paymentモデルバリデーション
  validates :postcode, format: {with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)'}
  validates :region_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city
  validates :street_adress
  validates :build_adress
  variants :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is inbalid' }
  end

  def save
    # 寄付情報を保存し、変数donationに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Payment.create(postal_code: postal_code, region_id: region_id, city: city, street_adress: street_adress, build_adress: build_adress, phohe_number: phone_number)
  end
end