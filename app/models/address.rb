class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates  :family_name, :first_name, :family_kana, :first_kana, :zipcode, :city, :street, presence: true
  validates  :zipcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates  :family_name, :first_name, format: {with: /A[一-龥ぁ-ん]+Z/}
  validates  :family_kana, :first_kana, format: {with: /\A[ぁ-んー－]+\z/}
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture
end
