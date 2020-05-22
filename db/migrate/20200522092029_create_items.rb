class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,           null: false, limit: 30
      t.text    :explanation,    null: false, limit: 1000
      t.string  :condition,      null: false
      t.string  :delivery_fee,   null: false
      t.string  :method,         null: false
      t.string  :date,           null: false
      t.integer :price,          null: false
      t.integer :prefecture_id,  null: false
      t.references :brand_id,    null: false, foreign_key: true
      t.references :seller_id,   null: false, foreign_key: true
      t.references :buyer_id,    foreign_key: true

      t.timestamps
    end
  end
end
