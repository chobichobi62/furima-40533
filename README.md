# README

## users Table

|Column            |Type  |Options                  |
|nickname----------|string|null: false, unique: true|
|email-------------|string|null: false, unique: true|
|encrypted_password|string|null: false, unique: true|
|family_name-------|string|null: false--------------|
|first_name--------|string|null: false--------------|
|family_name_kana--|string|null: false--------------|
|first_name_kana---|string|null: false--------------|
|birth-------------|date--|null: false--------------|

### Association
has_many :items
has_many :orders
has_many :comments

<!-- #email.passwordはGemを使用 -->


## items Table

|Column            |Type      |Options                       |
|user--------------|references|null: false, foreign_key: true|
|item_name---------|string----|null: false-------------------|
|description-------|text------|null: false-------------------|
|category_id-------|integer---|null: false-------------------|
|item_condition_id-|integer---|null: false-------------------|
|delivery_price_id-|integer---|null: false-------------------|
|region_id---------|integer---|null: false-------------------|
|delivery_time_id--|integer---|null: false-------------------|
|price-------------|integer---|null: false-------------------|

### Association
belongs_to :user
has_one :order
has_many :comments

<!-- #imageはGemを使用 -->


## orders Table

|Column|Type      |Options                       |
|user--|references|null: false, foreign_key: true|
|item--|references|null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :item
has_one :payment


## payments Table

|Column            |Type      |Options                       |
|order---------|references|null: false, foreign_key: true|
|post_code-----|string----|null: false-------------------|
|region_id----|integer---|null: false-------------------|
|city----------|string----|null: false-------------------|
|street_address|string----|null: false-------------------|
|build_address-|string----|
|phone_number--|string----|null: false-------------------|

### Association
belongs_to :order