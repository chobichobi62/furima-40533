class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :region_id, :city, :street_address, :build_address, :phone_number, :token

  with_options presence: true do
    # orderモデルバリデーション
    validates :user_id
    validates :item_id
    # paymentモデルバリデーション
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :region_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :build_address, allow_blank: true
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
  end

  def save
    # 寄付情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    Payment.create(postcode:, region_id:, city:, street_address:,
                   build_address:, phone_number:, order_id:)
  end
end
