class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :zipcode,       null: false
      t.string     :city,          null: false
      t.string     :street,        null: false
      t.string     :apartment    
      # t.references :prefecture,    null: false, foreign_key: true
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
