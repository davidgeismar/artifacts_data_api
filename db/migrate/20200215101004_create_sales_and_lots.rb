class CreateSalesAndLots < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_organizers do |t|
      t.string :company_name
    end

    # check wtf is wrong with uuid

    create_table :sales do |t|
      t.jsonb :dump
      t.string :title
      t.string :original_id
      t.string :location
      t.string :currency
      t.datetime :start_date
      t.datetime :end_date
      t.integer :total
      t.references :sale_organizer, foreign_key: true

      t.timestamps
    end

    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :birth_year
      t.string :death_year
      t.string :period
      t.string :original_title1

      t.timestamps
    end

    create_table :lots do |t|
      t.jsonb :dump
      t.string :title1
      t.string :title2
      t.string :original_object_id
      t.integer :primary_price
      t.integer :secondary_price
      t.string  :price_label
      t.string :currency
      t.integer :low_estimate
      t.integer :high_estimate
      t.references :sale, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
    add_index :sales, [:original_id, :sale_organizer_id], unique: true
    add_index :lots, [:original_object_id, :sale_id], unique: true
  end
end
