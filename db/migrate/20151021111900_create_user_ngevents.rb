class CreateUserNgevents < ActiveRecord::Migration
  def change
    create_table :user_ngevents do |t|
      t.references :user, index: true
      t.references :listing, index: true, null: true
      t.references :reservation, index: true, null: true
      t.string :reason, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.boolean :active, default: true
      t.timestamps null: false
    end
    add_foreign_key :user_ngevents, :users
    add_foreign_key :user_ngevents, :listings
    add_foreign_key :user_ngevents, :reservations
  end
end