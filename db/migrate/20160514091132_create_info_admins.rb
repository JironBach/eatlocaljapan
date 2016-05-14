class CreateInfoAdmins < ActiveRecord::Migration
  def change
    create_table :info_admins do |t|
      t.timestamps null: false

      t.string :name
      t.string :name_en
    end
  end
end
