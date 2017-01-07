class CreatePaymentMethod < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.references :user

      t.string :type
      t.string :encrypted_card_no1
      t.string :encrypted_card_no1_iv
      t.string :encrypted_card_no2
      t.string :encrypted_card_no2_iv
      t.string :encrypted_card_no3
      t.string :encrypted_card_no3_iv
      t.string :encrypted_card_no4
      t.string :encrypted_card_no4_iv
      t.integer :expired_year
      t.integer :expired_month
      t.integer :gmo_card_seq
      t.timestamp :registered_at

      t.timestamps
    end
  end
end
