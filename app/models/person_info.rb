class PersonInfo < ApplicationRecord
  validates  :family_name, :first_name, :family_kana, :first_kana,
             :birth_date,   presence: true
  validates  :family_name, :first_name, format: {with: /A[一-龥ぁ-ん]+Z/}
  validates  :family_kana, :first_kana, format: {with: /\A[ぁ-んー－]+\z/}
  belongs_to :user, optional: true
end