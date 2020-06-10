require 'rails_helper'

describe User do 
  describe '#create' do
    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid     
    end

    it "nicknameがないと登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがないと登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがないと登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は不正な値です")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "重複したemailは登録できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "@がないとemailは登録できないこと" do
      user = build(:user, email: "abbnb.jp")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "ドメインがないとemailは登録できないこと" do
      user = build(:user, email: "aaa@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "passwordが半角英数字7文字以上であれば登録できること" do
      user = build(:user, password: "123456q", password_confirmation: "123456q")
      user.valid?
      expect(user).to be_valid
    end

    it " passwordが6文字以下であれば登録できないこと" do
      user = build(:user, password: "12345q", password_confirmation: "12345q")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください", "は不正な値です")
    end

    it "passwordは全角英数字であれは登録できないこと" do
      user = build(:user, password: "123456Q", password_confirmation: "123456Q")
      user.valid?
      expect(user.errors[:password]).to include("は不正な値です")
    end

    it "passwordは数字のみであれは登録できないこと" do
        user = build(:user, password: "1234567", password_confirmation: "1234567")
        user.valid?
        expect(user.errors[:password]).to include("は不正な値です")
    end

    it "passwordは半角英字のみであれは登録できないこと" do
      user = build(:user, password: "abcdefg", password_confirmation: "abcdefg")
      user.valid?
      expect(user.errors[:password]).to include("は不正な値です")
    end

  end
end