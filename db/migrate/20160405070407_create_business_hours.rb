class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.timestamps null: false

      t.references :listing
      t.integer :wday, null: false
      t.boolean :is_open, null: false, default: true
      t.time :start_hour
      t.time :end_hour
    end

    add_index :business_hours, [:listing_id, :wday], unique: true
  end
end
