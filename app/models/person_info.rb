class PersonInfo < ApplicationRecord
  validates  :family_name, :first_name, :family_kana, :first_kana,
             :birth_date,   presence: true
  belongs_to :user
end