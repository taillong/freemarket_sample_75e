require 'rails_helper'

describe Item do
  describe '#create' do
    context 'itemを保存できること' do
      it "name,explanation,condition_id,delivery_fee_id,duration_id,price,prefecture_id,brand_id,category_id,seller_id,imagesがあれば保存できること" do
        item = build(:item,:with_images)
        expect(item).to be_valid
      end
    end
  end
end