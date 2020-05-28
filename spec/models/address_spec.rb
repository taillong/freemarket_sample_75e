require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#create' do 
    it "すべてのカラムがあれば登録できる" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "family_nameがないと登録できない" do
      address = build(:address, family_name: nil)
      address.valid?
      expect(address.errors[:family_name]).to include("を入力してください")
    end

    it "first_nameがないと登録できない" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "family_kanaがないと登録できない" do
      address = build(:address, family_kana: nil)
      address.valid?
      expect(address.errors[:family_kana]).to include("を入力してください")
    end

    it "first_kanaがないと登録できない" do
      address = build(:address, first_kana: nil)
      address.valid?
      expect(address.errors[:first_kana]).to include("を入力してください")
    end

    it "zipcodeがないと登録できない" do
      address = build(:address, zipcode: nil)
      address.valid?
      expect(address.errors[:zipcode]).to include("を入力してください")
    end

    it "cityがないと登録できない" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "streetがないと登録できない" do
      address = build(:address, street: nil)
      address.valid?
      expect(address.errors[:street]).to include("を入力してください")
    end

    it "apartmentがなくても登録できる" do
      expect(build(:address, apartment: nil)).to be_valid
    end

    it "tellがなくても登録できる" do
      expect(build(:address, tell: nil)).to be_valid
    end

    it "family_nameが全角でないと登録できない" do
      address = build(:address, family_name: "yamada")
      address.valid?
      expect(address.errors[:family_name]).to include("は不正な値です")
    end

    it "first_nameが全角でないと登録できない" do
      address = build(:address, first_name: "aoi")
      address.valid?
      expect(address.errors[:first_name]).to include("は不正な値です")
    end

    it "family_kanaが全角カナだと登録できない" do
      address = build(:address, family_kana: "ヤマダ")
      address.valid?
      expect(address.errors[:family_kana]).to include("は不正な値です")
    end

    it "family_kanaがローマ字だと登録できない" do
      address = build(:address, family_kana: "yamada")
      address.valid?
      expect(address.errors[:family_kana]).to include("は不正な値です")
    end

    it "family_kanaが漢字だと登録できない" do
      address = build(:address, family_kana: "山田")
      address.valid?
      expect(address.errors[:family_kana]).to include("は不正な値です")
    end

    it "first_kanaが全角カナだと登録できない" do
      address = build(:address, first_kana: "アヤ")
      address.valid?
      expect(address.errors[:first_kana]).to include("は不正な値です")
    end

    it "first_kanaがローマ字だと登録できない" do
      address = build(:address, first_kana: "アヤ")
      address.valid?
      expect(address.errors[:first_kana]).to include("は不正な値です")
    end

    it "first_kanaが漢字だと登録できない" do
      address = build(:address, first_kana: "綾")
      address.valid?
      expect(address.errors[:first_kana]).to include("は不正な値です")
    end

    it "zipcodeに-がないと登録できない" do
      address = build(:address, zipcode: "1234567")
      address.valid?
      expect(address.errors[:zipcode]).to include("は不正な値です")
    end

    it "zipcodeに不適切な形だど登録できない" do
      address = build(:address, zipcode: "12345-67")
      address.valid?
      expect(address.errors[:zipcode]).to include("は不正な値です")
    end

    it "zipcodeが全角だど登録できない" do
      address = build(:address, zipcode: "１２３ー４５６７")
      address.valid?
      expect(address.errors[:zipcode]).to include("は不正な値です")
    end

    it "tellに数字以外があると登録できない" do
      address = build(:address, tell: "090-1234-5678")
      address.valid?
      expect(address.errors[:tell]).to include("は不正な値です")
    end

    it "tellの数字が全角だと登録できない" do
      address = build(:address, tell: "０９０１２３４５６７８")
      address.valid?
      expect(address.errors[:tell]).to include("は不正な値です")
    end

  end
end
