class AddActiveToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :active, :boolean, null: false, default: true
  end
end
