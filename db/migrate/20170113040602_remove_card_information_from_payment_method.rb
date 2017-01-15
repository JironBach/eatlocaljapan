class RemoveCardInformationFromPaymentMethod < ActiveRecord::Migration
  def up
    change_table :payment_methods do |t|
      t.remove :encrypted_card_no1
      t.remove :encrypted_card_no1_iv
      t.remove :encrypted_card_no2
      t.remove :encrypted_card_no2_iv
      t.remove :encrypted_card_no3
      t.remove :encrypted_card_no3_iv
      t.remove :encrypted_card_no4
      t.remove :encrypted_card_no4_iv
      t.remove :expired_year
      t.remove :expired_month

      t.string :card_no
      t.string :expired_on
    end
  end

  def down
    change_table :payment_methods do |t|
      t.remove :card_no
      t.remove :expired_on

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
    end
  end
end
