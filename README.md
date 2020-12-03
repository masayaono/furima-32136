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
| post_code                    | integer(7) | null:false                     |
| prefecture_code              | integer    | null:false                     |
| city                         | string     | null:false                     |
| house_number                 | string     | null:false                     |
| building_name                | string     |                                |
| phone_number                 | string     | unique: true                   |
| user                         | references | null: false, foreign_key: true |

### Association

* belongs_to :user
* Gem：jp_prefectureを使用して都道府県コードを取得

 ## items table

| Column           | Type       | Options                      |
|------------------|------------|------------------------------|
| name             | string     | null:false                   |
| introduction     | text       | null:false                   |
| price            | integer    | null:false                   |
| brand            | references | foreign_key:true             |
| item_condition   | references | null:false, foreign_key:true |
| postage_payer    | references | null:false, foreign_key:true |
| prefecture_code  | integer    | null:false                   |
| size             | references | null:false, foreign_key:true |
| preparation_day  | references | null:false, foreign_key:true |
| postage_type     | references | null:false, foreign_key:true |
| item_img         | references | null:false, foreign_key:true |
| category         | references | null:false, foreign_key:true |
| trading_status   | enum       | null:false                   |
| seller           | references | null:false, foreign_key:true |
| buyer            | references | foreign_key:true             |
| deal_closed_date | timestamp  |                              |

### Association
* has_many:comments, dependent: :destroy
* has_many:favorites
* has_many:item_imgs, dependent: :destroy
* has_one:user_evaluation
* belongs_to:category
* belongs_to_active_hash:size
* belongs_to_active_hash:item_condition
* belongs_to_active_hash:postage_payer
* belongs_to_active_hash:preparation_day
* belongs_to_active_hash:postage_type
* belongs_to:brand
* belongs_to:seller, class_name: "User"
* belongs_to:buyer, class_name: "User"


 ## brands table

| Column | Type   | Options |
|--------|--------|---------|
| name   | string |         |

### Association

* has_many:items

 ## item_imgs table

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| url    | string     | null:false                     |
| item   | references | null: false, foreign_key: true |

### Association

* belongs_to:item

 ## favorites table


| Column | Type       | Options                      |
| user   | references | null:false, foreign_key:true |
| item   | references | null:false, foreign_key:true |

### Association

* belongs_to :user
* belongs_to :item

 ## categories table

| Column   | Type   | Options    |
|----------|--------|------------|
| name     | string | null:false |
| ancestry | string | null:false |

### Association

* has_many :items