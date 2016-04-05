class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.string :menu, null: false
      t.string :menu_en
      t.string :description
      t.string :description_en
      #t.string :image
    end
  end
end
