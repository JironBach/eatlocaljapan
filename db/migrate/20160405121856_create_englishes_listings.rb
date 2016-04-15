class CreateEnglishesListings < ActiveRecord::Migration
  def change
    create_table :englishes_listings do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :english, null: false
    end

    add_index :englishes_listings, [:listing_id, :english_id], unique: true
  end
end
