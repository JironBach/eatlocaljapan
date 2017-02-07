class AddColumnAboutLunchBreakInBusinessHour < ActiveRecord::Migration
  def change
    change_table :business_hours do |t|
      t.boolean :has_lunch_break, null: false, default: false
    end
  end
end
