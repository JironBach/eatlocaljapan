class CreateEnglishes < ActiveRecord::Migration
  def change
    create_table :englishes do |t|

      t.string :name, null: false
      t.string :name_en, null: false
    end
  end
end
