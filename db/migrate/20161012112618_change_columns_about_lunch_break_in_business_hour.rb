class ChangeColumnsAboutLunchBreakInBusinessHour < ActiveRecord::Migration
  def change
    change_table :business_hours do |t|
      t.string :type
      t.time :lunch_break_start_hour
      t.time :lunch_break_end_hour
    end
    reversible do |dir|
      change_table :business_hours do |t|
        dir.up do
          t.change :wday, :integer, null: true
          t.remove_index column: [:listing_id, :wday]
          t.index [:listing_id, :wday]
        end
        dir.down do
          t.change :wday, :integer, null: false
          t.remove_index column: [:listing_id, :wday]
          t.index [:listing_id, :wday], unique: true
        end
      end
    end
  end
end
