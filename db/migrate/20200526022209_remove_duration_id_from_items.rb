class RemoveDurationIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :duration_id, :integer
  end
end
