class Address < ApplicationRecord
  validates  :zipcode, :city, :street, presence: true
  belongs_to :user
  belongs_to_active_hash :prefecture
end
