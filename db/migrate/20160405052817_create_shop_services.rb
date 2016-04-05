class CreateShopServices < ActiveRecord::Migration
  def change
    create_table :shop_services do |t|
      t.timestamps null: false

      t.string :name, null: false
      t.string :name_en, null: false
    end
  end
end
