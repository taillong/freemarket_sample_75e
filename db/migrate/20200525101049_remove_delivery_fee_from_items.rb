class RemoveDeliveryFeeFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :delivery_fee, :string
  end
end
