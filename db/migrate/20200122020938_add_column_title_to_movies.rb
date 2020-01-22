class AddColumnTitleToMovies < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :title, :description
  end
end
