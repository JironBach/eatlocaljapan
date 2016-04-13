class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.timestamps null: false

      t.references :listing
      t.boolean :is_open, null: false, default: true
      t.integer :wday, null: false
      t.time :start_hour
      t.time :end_hour
    end
  end
end
