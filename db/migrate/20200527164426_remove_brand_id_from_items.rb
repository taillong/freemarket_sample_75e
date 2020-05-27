class RemoveBrandIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :brand_id, :reference
  end
end
