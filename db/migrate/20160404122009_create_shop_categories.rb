class CreateShopCategories < ActiveRecord::Migration
  def change
    create_table :shop_categories do |t|
      t.timestamps null: false

      t.string :name, null: false
      t.string :name_en, null: false
    end
  end
end
