class CreateListingEnglishes < ActiveRecord::Migration
  def change
    create_table :listing_englishes do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :english, null: false
    end

    add_index :listing_englishes, [:listing_id, :english_id], unique: true
  end
end
