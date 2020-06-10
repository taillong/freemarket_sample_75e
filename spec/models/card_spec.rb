require 'rails_helper'

RSpec.describe Card, type: :model do
  describe '#create' do
    it "すべてのカラムがあれば登録ができる" do
      card = build(:card)
      expect(card).to be_valid  
    end

    it "customer_idがないと登録できない" do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idがないと登録できない" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

    it "user_idがないと登録できない" do
      card = build(:card, user_id: nil)
      card.valid?
      expect(card.errors[:user]).to include("を入力してください")
    end
  end
end
