class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :order,         null: false, foreign_key: true
      t.string     :postcode,      null: false
      t.integer    :region_id,     null: false
      t.string     :city,          null:false
      t.string     :street_address, null:false
      t.string     :build_address
      t.string     :phone_number,  null:false
      t.timestamps
    end
  end
end