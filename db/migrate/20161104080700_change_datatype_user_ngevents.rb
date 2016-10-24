class ChangeDatatypeUserNgevents < ActiveRecord::Migration
  def change
    change_table :user_ngevents do |t|
      reversible do |dir|
        dir.up { t.change :reason, :integer, using: "case reason when 'holiday' then 0 when 'reserved' then 1 when 'canceled' then 2 when 'temporary_closed' then 3 end" }
        dir.down { t.change :reason, :string, using: "case reason when 0 then 'holiday' when 1 then 'reserved' when 2 then 'canceled' when 3 then 'temporary_closed' end" }
      end
    end
  end
end
