class ChangeDefaultOfChargeStatus < ActiveRecord::Migration
  def up
    change_table :charges do |t|
      t.change_default :status, 0
    end
  end

  def down
    change_table :charges do |t|
      t.change_default :status, nil
    end
  end
end
