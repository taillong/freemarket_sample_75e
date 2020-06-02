class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,           null: false, limit: 30
      t.text    :explanation,    null: false, limit: 1000
      t.string  :condition,      null: false
      t.string  :delivery_fee,   null: false
      t.string  :method,         null: false
      t.string  :duration,       null: false
      t.integer :price,          null: false
      t.integer :prefecture_id,  null: false
      t.references :brand,       null: false, foreign_key: true
      t.references :seller,      null: false, foreign_key: { to_table: :users }
      t.references :buyer,       foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end