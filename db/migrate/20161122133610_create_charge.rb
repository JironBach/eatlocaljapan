class CreateCharge < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :service

      t.string :type
      t.string :charger_type
      t.integer :charger_id
      t.string :payment_method_type
      t.integer :payment_method_id

      t.integer :status
      t.integer :order_no
      t.date :expiration_date
      t.timestamp :ordered_at

      t.timestamps
    end
  end
end
