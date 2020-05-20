freemarket_sample_75e　DB設計

## Productsテーブル
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
|product_id|integer|null: false, foregin_key: true|
### Association
- belongs_to :products

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false , unique: true , index: true|
|email   |string||
|password|string|null: false, unique: true, index: true|
- has_many :products

## adressesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture_id |integer|null: false, foreign_key: true|
|zipcode       |string |null: false |
|city          |string |null: false |
|street        |string |null: false |
|apartment     |string | |
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
- belongs_to :user
