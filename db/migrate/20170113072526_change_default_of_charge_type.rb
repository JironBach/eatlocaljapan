class ChangeDefaultOfChargeType < ActiveRecord::Migration
  def up
    change_table :services do |t|
      t.change_default :charge_type, 0
    end
  end

  def down
    change_table :services do |t|
      t.change_default :charge_type, nil
    end
  end
end
