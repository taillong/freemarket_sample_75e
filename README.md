freemarket_sample_75e DB設計

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, limit:30|
|explanation|text|null: false, limit:1000|
|condition|string|null: false|
|delivery_fee|string|null: false|
|method|string|null: false|
|date|string|null: false|
|price|integer|null: false|
|prefecture_id|integer|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
### Association
- has_many :images, dependent: :destroy
- has_many :category_items
- has_many :categories,  through: :category_items
- belongs_to :brand
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|img|string|null: false|
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
|prefecture_id |integer|null: false, foreign_key: true|
|zipcode       |string |null: false |
|city          |string |null: false |
|street        |string |null: false |
|apartment     |string | |
### Association
- belongs_to :user

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

### Association
- has_many :category_items
- has_many :items ,through: :category_items


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|add_index|
### Association
- has_many :items

## category_itemsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :category

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id |references|null: false, foreign_key: true|
|customer_id| integer| null: false |
|card_id |integer |null: false |
### Association
- belongs_to :user

## shippingテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string |null: false |
|first_name |string |null: false |
|family_kana|string |null: false |
|first_kana |string |null: false |
|zipcode   |string |null: false |
|prefecture_id|integer|null: false, foreign_key: true |
|city|string|null: false |
|street|string|null: false |
|apartment|string| |
|tell|string| |
### Association
- has_many :users
- belongs_to :prefecture
