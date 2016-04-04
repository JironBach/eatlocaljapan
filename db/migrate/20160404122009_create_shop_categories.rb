class CreateShopCategories < ActiveRecord::Migration
  def change
    create_table :shop_categories do |t|
      t.timestamps null: false

      t.string :name, null: false
    end
  end
end
