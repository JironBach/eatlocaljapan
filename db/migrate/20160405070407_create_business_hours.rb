class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.timestamps null: false

      t.integer :wday, null: false
      t.integer :start_hour, null: false
      t.integer :end_hour, null: false
    end
  end
end
