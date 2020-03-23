class AddIndexToArtistName < ActiveRecord::Migration[6.0]
  def change
    add_index :artists, :full_name, unique: false
  end
end
