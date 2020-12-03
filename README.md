# DB設計

## users table

| Column             | Type   | Options                              |
|--------------------|--------|--------------------------------------|
| nickname           | string | null:false                           |
| encrypted_password | string | null:false                           |
| email              | string | null:false, unique:true, index:true  |
| first_name         | string | null:false                           |
| family_name        | string | null:false                           |
| first_name_kana    | string | null:false                           |
| family_name_kana   | string | null:false                           |
| birth_strftime     | date   | null:false                           |

### Association

* has_many:favorites, dependent: :destroy
* has_many:user_evaluations
* has_many:seller_items, foreign_key: "seller_id", class_name: "items"
* has_many:buyer_items, foreign_key: "buyer_id", class_name: "items"
* has_one:sending_destination, dependent: :destroy
* has_many:purchase_managements

 ## user_evaluations table

| Column     | Type       | Options                       |
|------------|------------|-------------------------------|
| review     | text       | null:false                    |
| user       | references | null:false, foreign_key: true |
| item       | references | null:false, foreign_key: true |
| evaluation | references | null:false, foreign_key: true |

### Association

* belongs_to_active_hash:evaluation
* belongs_to:user
* belongs_to:item

 ## sending_destinations table

| Column                       | Type       | Options                        |
|------------------------------|------------|--------------------------------|
| post_code                    | string     | null:false                     |
| prefecture_id                | integer    | null:false                     |
| city                         | string     | null:false                     |
| house_number                 | string     | null:false                     |
| building_name                | string     |                                |
| phone_number                 | string     | unique: true                   |
| purchase_management          | references | null: false, foreign_key: true |

### Association

* belongs_to :purchase_management
* Gem：jp_prefectureを使用して都道府県コードを取得

 ## items table

| Column             | Type       | Options                      |
|--------------------|------------|------------------------------|
| user               | references | null:false, foreign_key:true |
| name               | string     | null:false                   |
| introduction       | text       | null:false                   |
| price              | integer    | null:false                   |
| item_condition_id  | integer    | null:false                   |
| postage_payer_id   | integer    | null:false                   |
| prefecture_id      | integer    | null:false                   |
| preparation_day_id | integer    | null:false                   |
| category_id        | integer    | null:false                   |

### Association
* belongs_to:user
* has_many:comments, dependent: :destroy
* has_many:favorites
* has_many:item_imgs, dependent: :destroy
* has_one:user_evaluation
* belongs_to:brand
* belongs_to:seller, class_name: "User"
* belongs_to:buyer, class_name: "User"

 ## favorites table


| Column | Type       | Options                      |
|--------|------------|------------------------------|
| user   | references | null:false, foreign_key:true |
| item   | references | null:false, foreign_key:true |

### Association

* belongs_to :user
* belongs_to :item

 ## purchase_management table

| Column | Type       | Options                      |
|--------|------------|------------------------------|
| user   | references | null:false, foreign_key:true |
| item   | references | null:false, foreign_key:true |


### Association

* belongs_to :user
* belongs_to :item
* belongs_to :sending_destination