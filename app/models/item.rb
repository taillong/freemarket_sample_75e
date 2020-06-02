class Item < ApplicationRecord

  has_many :images, dependent: :destroy
  has_many :category_items
  has_many :categories, through: :category_items
  # belongs_to_active_hash :prefecture
  belongs_to :brand
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'

  
end
