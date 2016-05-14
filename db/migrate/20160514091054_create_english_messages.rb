class CreateEnglishMessages < ActiveRecord::Migration
  def change
    create_table :english_messages do |t|
      t.timestamps null: false

      t.string :name
      t.string :name_en
    end
  end
end
