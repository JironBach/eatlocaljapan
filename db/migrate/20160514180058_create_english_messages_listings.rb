class CreateEnglishMessagesListings < ActiveRecord::Migration
  def change
    create_table :english_messages_listings do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :english_message, null: false
    end
  end
end
