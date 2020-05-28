require 'rails_helper'

RSpec.describe PersonInfo, type: :model do
  describe '#create' do
    it "すべてのカラムがあれば登録ができる" do
      person_info = build(:person_info)
      expect(person_info).to be_valid  
    end

    it "family_nameがないと登録できない" do
      person_info = build(:person_info, family_name: nil)
      person_info.valid?
      expect(person_info.errors[:family_name]).to include("を入力してください")
    end

    it "first_nameがないと登録できない" do
      person_info = build(:person_info, first_name: nil)
      person_info.valid?
      expect(person_info.errors[:first_name]).to include("を入力してください")
    end

    it "family_kanaがないと登録できない" do
      person_info = build(:person_info, family_kana: nil)
      person_info.valid?
      expect(person_info.errors[:family_kana]).to include("を入力してください")
    end

    it "first_kanaがないと登録できない" do
      person_info = build(:person_info, first_kana: nil)
      person_info.valid?
      expect(person_info.errors[:first_kana]).to include("を入力してください")
    end

    it "birth_dateがないと登録できない" do
      person_info = build(:person_info, birth_date: nil)
      person_info.valid?
      expect(person_info.errors[:birth_date]).to include("を入力してください")
    end

    it "family_nameが全角でないと登録できない" do
      person_info = build(:person_info, family_name: "yaaa")
      person_info.valid?
      expect(person_info.errors[:family_name]).to include("は不正な値です")
    end

    it "first_nameが全角でないと登録できない" do
      person_info = build(:person_info, first_name: "カナ")
      person_info.valid?
      expect(person_info.errors[:first_name]).to include("は不正な値です")
    end

    it "family_kanaが全角カナだと登録できない" do
      person_info = build(:person_info, family_kana: "ヤマダ")
      person_info.valid?
      expect(person_info.errors[:family_kana]).to include("は不正な値です")
    end

    it "family_kanaがローマ字だと登録できない" do
      person_info = build(:person_info, family_kana: "yamada")
      person_info.valid?
      expect(person_info.errors[:family_kana]).to include("は不正な値です")
    end

    it "family_kanaが漢字だと登録できない" do
      person_info = build(:person_info, family_kana: "山田")
      person_info.valid?
      expect(person_info.errors[:family_kana]).to include("は不正な値です")
    end

    it "first_kanaが全角カナだと登録できない" do
      person_info = build(:person_info, first_kana: "アヤ")
      person_info.valid?
      expect(person_info.errors[:first_kana]).to include("は不正な値です")
    end

    it "first_kanaがローマ字だと登録できない" do
      person_info = build(:person_info, first_kana: "アヤ")
      person_info.valid?
      expect(person_info.errors[:first_kana]).to include("は不正な値です")
    end

    it "first_kanaが漢字だと登録できない" do
      person_info = build(:person_info, first_kana: "綾")
      person_info.valid?
      expect(person_info.errors[:first_kana]).to include("は不正な値です")
    end

    it "birth_dateの年がないと登録できない" do
      person_info = build(:person_info, birth_date: "01-01")
      person_info.valid?
      expect(person_info.errors[:birth_date]).to include("を入力してください")
    end

    it "birth_dateの月がないと登録できない" do
      person_info = build(:person_info, birth_date: "2020-31")
      person_info.valid?
      expect(person_info.errors[:birth_date]).to include("を入力してください")
    end
      
    it "birth_dateの日がないと登録できない" do
      person_info = build(:person_info, birth_date: "2020-01")
      person_info.valid?
      expect(person_info.errors[:birth_date]).to include("を入力してください")
    end

    # it "user_idがないと登録できない" do
    #   person_info = build(:person_info, user_id: nil)
    #   person_info.valid?
    #   expect(person_info.errors[:user_id]).to include("を入力してください")
    # end
  end
end