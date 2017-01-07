class AddBranchSequenceToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :gmo_member_seq, default: 0
    end
  end
end
