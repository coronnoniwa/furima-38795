## usersテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| nickname           | string     | null: false               |
| last_name           | string     | null: false               |
| first_name          | string     | null: false               |
| how_last_name       | string     | null: false               |
| how_first_name      | string     | null: false               |

### Association

- has_many :items
- has_many :oders

## itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| condition           | string     | null: false                    |
| delivery_charge     | string     | null: false                    |
| shipping_prefecture | string     | null: false,                   |
| days                | string     | null: false,                   |
| price               | integer    | null: false,                   |
| user_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :oder

## odersテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | references | null: false, foreign_key: true |
| item_id    | references | null: false, foreign_key: true |
| address_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| delivery_prefecture | string     | null: false                    |
| delivery_city       | string     | null: false,                   |
| delivery_address    | text       | null: false,                   |
| delivery_building   | string     | null: false,                   |
| telephone_number    | integer    | null: false,                   |
| oder_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :oder