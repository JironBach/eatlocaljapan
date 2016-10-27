class AddColumnsAboutReservationSettingToListings < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.integer :reservation_frame
      t.integer :unit
      t.integer :from
      t.integer :to
      t.integer :reservation_time_unit
    end
  end
end
