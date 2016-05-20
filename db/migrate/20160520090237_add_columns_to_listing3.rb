class AddColumnsToListing3 < ActiveRecord::Migration
  def change
    add_column :listings, :location_en, :string
    add_column :listings, :visit_benefits_en, :string
    add_column :listings, :visit_benefits_another_en, :string
  end
end
