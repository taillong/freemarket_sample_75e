class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name
      t.index  :name, unique: true
      t.timestamps
    end
  end
end
