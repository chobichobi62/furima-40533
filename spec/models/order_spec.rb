require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
end

describe '配送先情報の保存' do
  context '配送先情報の保存ができるとき' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_form).to be_valid
    end

    it 'user_idが空でなければ保存できる' do
      @order_form.user_id = 1
      expect(@order_form).to be_valid
    end

    it 'item_idが空でなければ保存できる' do
      @order_form.item_id = 1
      expect(@order_form).to be_valid
    end

    it 'postcodeが「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
      @order_form.postcode = '123-4560'
      expect(@order_form).to be_valid
    end

    it 'regionが「---」以外かつ空でなければ保存できる' do
      @order_form.region_id = 1
      expect(@order_form).to be_valid
    end

    it 'cityが空でなければ保存できる' do
      @order_form.city = '横浜市'
      expect(@order_form).to be_valid
    end

    it 'street_addressが空でなければ保存できる' do
      @order_form.street_address = '豊島区１２３'
      expect(@order_form).to be_valid
    end

    it 'build_addressが空でも保存できる' do
      @order_form.build_address = nil
      expect(@order_form).to be_valid
    end

    it 'phone_numberが11番桁以内かつハイフンなしであれば保存できる' do
      @order_form.phone_number = 12_345_678_910
      expect(@order_form).to be_valid
    end
end

context '配送先情報の保存ができないとき' do
  it 'user_idが空だと保存できない' do
    @order_form.user_id = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("User can't be blank")
  end

  it 'item_idが空だと保存できない' do
    @order_form.item_id = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Item can't be blank")
  end

  it 'postcodeが空だと保存できないこと' do
    @order_form.postcode = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Postcode can't be blank", 'Postcode is invalid. Include hyphen(-)')
  end

  it 'postcodeにハイフンがないと保存できないこと' do
    @order_form.postcode = 1_234_567
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
  end

  it 'regionが「---」だと保存できないこと' do
    @order_form.region_id = 0
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Region can't be blank")
  end

  it 'regionが空だと保存できないこと' do
    @order_form.region_id = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Region can't be blank")
  end

  it 'cityが空だと保存できないこと' do
    @order_form.city = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("City can't be blank")
  end

  it 'street_addressが空だと保存できないこと' do
    @order_form.street_address = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Street address can't be blank")
  end

  it 'phone_numberが空だと保存できないこと' do
    @order_form.phone_number = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
  end

  it 'phone_numberにハイフンがあると保存できないこと' do
    @order_form.phone_number = '123 - 1234 - 1234'
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include('Phone number is invalid')
  end

  it 'phone_numberが12桁以上あると保存できないこと' do
    @order_form.phone_number = 12_345_678_910_123_111
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include('Phone number is invalid')
  end
  it "tokenが空では登録できないこと" do
    @order_form.token = nil
    @order_form.valid?
    expect(@order_form.errors.full_messages).to include("Token can't be blank")
  end
end
end
end