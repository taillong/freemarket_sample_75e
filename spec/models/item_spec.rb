require 'rails_helper'

describe Item do
  describe '#create' do
    context 'itemを保存できること' do
      it "name,explanation,condition_id,delivery_fee_id,duration_id,price,prefecture_id,brand_id,category_id,seller_id,imagesがあれば保存できること" do
        user = build(:item, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it "emailがない場合は登録できないこと" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
    end
  end
end