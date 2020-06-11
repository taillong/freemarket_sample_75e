require 'rails_helper'

describe Item do
  describe '#create' do
    context 'itemを保存できること' do
      it "name,explanation,condition_id,delivery_fee_id,duration_id,price,prefecture_id,brand_id,category_id,seller_id,imagesがあれば保存できること" do
        item = build(:item,:with_images)
        expect(item).to be_valid
      end
      it "brand_idがなくても保存できること" do
        item = build(:item,:with_images, brand_id: nil)
        expect(item).to be_valid
      end
    end
    context 'itemを保存できないこと' do
      it "nameがないと保存でないこと" do
        item = build(:item,:with_images, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end
      it "explanationがないと保存でないこと" do
        item = build(:item,:with_images, explanation: nil)
        item.valid?
        expect(item.errors[:explanation]).to include("を入力してください")
      end
      it "condition_idがないと保存でないこと" do
        item = build(:item,:with_images, condition_id: nil)
        item.valid?
        expect(item.errors[:condition_id]).to include("を入力してください")
      end
      it "delivery_fee_idがないと保存でないこと" do
        item = build(:item,:with_images, delivery_fee_id: nil)
        item.valid?
        expect(item.errors[:delivery_fee_id]).to include("を入力してください")
      end
      it "duration_idがないと保存でないこと" do
        item = build(:item,:with_images, duration_id: nil)
        item.valid?
        expect(item.errors[:duration_id]).to include("を入力してください")
      end
      it "priceがないと保存でないこと" do
        item = build(:item,:with_images, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end
      it "prefecture_idがないと保存でないこと" do
        item = build(:item,:with_images, prefecture_id: nil)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("を入力してください")
      end
      it "category_idがないと保存でないこと" do
        item = build(:item,:with_images, category_id: nil)
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
      end
      it "seller_idがないと保存でないこと" do
        item = build(:item,:with_images, seller: nil)
        item.valid?
        expect(item.errors[:seller]).to include("を入力してください")
      end
      it "imagesがないと保存でないこと" do
        item = build(:item)
        item.valid?
        expect(item.errors[:images]).to include("を入力してください")
      end
    end
  end

  describe ItemsController , type: :controller do
    let(:user) { create(:user) }
    before do
      login user
    end

    describe 'POST #create' do
      it "データベースにitemを新規登録すること" do
        images = {images_attributes: {"0":attributes_for(:image)}}
        
        expect{post :create, params: {item: attributes_for(:item).merge(images)}}.to change(Item, :count).by(1)
      end
    end
  end
end