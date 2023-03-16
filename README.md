## usersテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| nickname           | string     | null: false               |
| last_name          | string     | null: false               |
| first_name         | string     | null: false               |
| how_last_name      | string     | null: false               |
| how_first_name     | string     | null: false               |
| birthday           | datetime   | null: false               |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| item_name              | string     | null: false                    |
| explanation            | text       | null: false                    |
| condition_id           | integer    | null: false                    |
| delivery_charge_id     | integer    | null: false                    |
| prefecture_id          | integer    | null: false,                   |
| days_id                | integer    | null: false,                   |
| price                  | integer    | null: false,                   |
| category_id            | integer    | null: false,                   |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| post_code           | integer    | null: false,                   |
| prefecture_id       | string     | null: false                    |
| delivery_city       | string     | null: false,                   |
| delivery_address    | string     | null: false,                   |
| delivery_building   | string     |                                |
| telephone_number    | string     | null: false,                   |
| order               | references | null: false, foreign_key: true |

### Association

- belongs_to :order