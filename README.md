freemarket_sample_75e DB設計

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, limit:30|
|explanation|text|null: false, limit:1000|
|condition|string|null: false|
|delivery_fee|string|null: false|
|method|string|null: false|
|data|string|null: false|
|price|integer|null: false|
|prefecture_id|string|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
### Association
- has_many :images
- has_many :category_products
- has_many :categorys,  through: :category_products
- belongs_to :brand
- belongs_to :prefecture
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|img|integer|null: false|
|item_id|integer|null: false, foregin_key: true|
### Association
- belongs_to :item

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false , unique: true , index: true|
|email   |string|null: false, unique: true, index: true|
|password|string|null: false, unique: true, index: true|
### Association
- has_many :items

## adressesテーブル
|Column|Type|Options|
|------|----|-------|
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
|person_id  |integer|null: false, foreign_key: true|
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
|type|string|null: false|

### Association
- has_many :category_items

## prefectyres
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|index: true|
### Association
- has_many :products

## category_itemsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foregin_key: true|
|category_id|references|null: false, foregin_key: true|
### Association
- belongs_to :items
- belongs_to :categories

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id |references|null: false, foreign_key: true|
|customer_id| integer| null: false |
|card_id |integer |null: false |
### Association
- belongs_to :user