require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品の購入' do
    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'delivery_buildingは空でも保存できること' do
        @order_address.delivery_building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が必須であること。' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_address.post_code = '123ー1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が必須であること。' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が必須であること。' do
        @order_address.delivery_city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Delivery city can't be blank")
      end
      it '番地が必須であること。' do
        @order_address.delivery_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Delivery address can't be blank")
      end
      it ' 電話番号が必須であること。' do
        @order_address.telephone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it ' 電話番号は、9桁以下では登録できないこと。' do
        @order_address.telephone_number = '090123412'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値のみ入力してください。')
      end
      it ' 電話番号は、12桁以上では登録できないこと。' do
        @order_address.telephone_number = '090123412345'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値のみ入力してください。')
      end
      it ' 電話番号は、半角数字以外が含まれている場合、登録できないこと。' do
        @order_address.telephone_number = '090ー1234ー1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Telephone number は10桁以上11桁以内の半角数値のみ入力してください。')
      end
      it ' tokenが必須であること。' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it ' userが必須であること。' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it ' itemが必須であること。' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
