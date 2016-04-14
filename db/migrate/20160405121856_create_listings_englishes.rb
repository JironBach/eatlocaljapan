class CreateListingsEnglishes < ActiveRecord::Migration
  def change
    create_table :listings_englishes do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :english, null: false
    end

    add_index :listings_englishes, [:listing_id, :english_id], unique: true
  end
end
