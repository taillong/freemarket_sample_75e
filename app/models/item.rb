class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :duration
  belongs_to :category
  belongs_to :brand
  
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  def self.brand_id_search(input)
    if input[:brand] != ""
      brand = Brand.find_by(name: input[:brand])
      brand_id = brand.id
      return brand_id
    end
  end

end
