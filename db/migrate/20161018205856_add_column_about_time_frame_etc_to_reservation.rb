class AddColumnAboutTimeFrameEtcToReservation < ActiveRecord::Migration
  def change
    change_table :reservations do |t|
      t.time :time
      t.integer :reservation_time_unit
      t.boolean :in_english
    end
  end
end
