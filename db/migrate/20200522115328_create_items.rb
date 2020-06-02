class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,              null: false, limit: 30
      t.text    :explanation,       null: false, limit: 1000
      t.integer  :condition_id,     null: false
      t.integer  :delivery_fee_id,  null: false
      t.integer  :duration_id,      null: false
      t.integer :price,             null: false
      t.integer :prefecture_id,     null: false
      t.bigint :brand_id,           foreign_key: true
      t.bigint :category_id,        null: false, foreign_key: true
      t.references :seller,         null: false, foreign_key: { to_table: :users }
      t.references :buyer,          foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end