require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.create(:item)
    sleep(1)
  end

  describe 'ユーザー新規登録' do
    context '出品できるとき' do
      it '全ての入力事項が、存在すれば登録できる' do
        expect(@item).to be_valid
      end

      it 'category_idが「---」以外であれば登録できる' do
        @item.category_id = 1
        expect(@item).to be_valid
      end

      it 'item_condition_idが「---」以外であれば登録できる' do
        @item.item_condition_id = 1
        expect(@item).to be_valid
      end

      it 'delivery_price_idが「---」以外であれば登録できる' do
        @item.delivery_price_id = 1
        expect(@item).to be_valid
      end

      it 'region_idが「---」以外であれば登録できる' do
        @item.region_id = 1
        expect(@item).to be_valid
      end

      it 'delivery_time_idが「---」以外であれば登録できる' do
        @item.delivery_time_id = 1
        expect(@item).to be_valid
      end

      it '価格が半角数字でかつ300円〜9,999,999円であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it 'user_idがないと出品できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist', "User can't be blank")
      end

      it 'imageが1枚ないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameが空欄だと出品できない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'descriptionが空欄だと出品できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idの情報が「---」だと出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'category_idの情報が空欄だと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
      end

      it 'item_condition_idの情報が「---」だと出品できない' do
        @item.item_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Item condition must be other than 0')
      end

      it 'item_condition_idの情報が空欄だと出品できない' do
        @item.item_condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank", 'Item condition is not a number')
      end

      it 'delivery_price_idの情報が「---」だと出品できない' do
        @item.delivery_price_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery price must be other than 0')
      end

      it 'delivery_price_idの情報が空欄だと出品できない' do
        @item.delivery_price_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery price can't be blank", 'Delivery price is not a number')
      end

      it 'region_idの情報が「---」だと出品できない' do
        @item.region_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Region must be other than 0')
      end

      it 'region_idの情報が空欄だと出品できない' do
        @item.region_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Region can't be blank", 'Region is not a number')
      end

      it 'delivery_time_idの情報が「---」だと出品できない' do
        @item.delivery_time_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery time must be other than 0')
      end

      it 'delivery_time_idの情報が空欄だと出品できない' do
        @item.delivery_time_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank", 'Delivery time is not a number')
      end

      it 'priceが空欄だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
      end

      it 'priceの範囲が、300円未満だと出品できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceの範囲が、9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
    end
  end
end
