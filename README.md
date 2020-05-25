freemarket_sample_75e DB設計

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, limit:30|
|explanation|text|null: false, limit:1000|
|condition_id|integer|null: false|
|delivery_fee_id|integer|null: false|
|method|string|null: false|
|duration|integer|null: false|
|price|integer|null: false|
|prefecture_id|integer|null: false|
|brand_id|references|foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
### Association
- has_many :images, dependent: :destroy
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :duration
- belongs_to :brand
- belongs_to :category
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false , unique: true , add_index|
|email   |string|null: false, unique: true, add_index|
|password|string|null: false, unique: true, add_index|
### Association
- has_one :card, dependent: :destroy
- has_one :address, dependent: :destroy
- has_one :person_info, dependent: :destroy
- has_many :sell_items, class_name: 'Item', foreign_key: 'seller_id',dependent: :destroy
- has_many :buy_items, class_name: 'Item', foreign_key: 'buyer_id'


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id       |integer|null: false, foreign_key: true|
|prefecture_id |integer|null: false|
|zipcode       |string |null: false |
|city          |string |null: false |
|street        |string |null: false |
|apartment     |string | |
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

## person_infosテーブル
|Column|Type|Options|
|------|----|-------|
|user_id    |integer|null: false, foreign_key: true|
|family_name|string |null: false |
|first_name |string |null: false |
|family_kana|string |null: false |
|first_kana |string |null: false |
|birth_year |integer|null: false |
|birth_month|integer|null: false |
|birth_day  |integer|null: false |
|tell       |integer| |
### Association
- belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|add_index|
|ancestry|string||
### Association
- has_many :category_items
- has_ancestry


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|add_index|
### Association
- has_many :items


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id |references|null: false, foreign_key: true|
|customer_id| integer| null: false |
|card_id |integer |null: false |
### Association
- belongs_to :user

