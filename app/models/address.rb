class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates  :zipcode, :city, :street, presence: true
  validates  :zipcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture
end
