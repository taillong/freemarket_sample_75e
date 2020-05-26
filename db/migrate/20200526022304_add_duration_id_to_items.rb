class AddDurationIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :duration_id, :integer
  end
end
