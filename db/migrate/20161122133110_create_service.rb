class CreateService < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :name_en
      t.string :code
      t.integer :charge_type
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
