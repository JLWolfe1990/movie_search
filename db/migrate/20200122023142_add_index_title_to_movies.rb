class AddIndexTitleToMovies < ActiveRecord::Migration[6.0]
  def change
    add_index :movies, :title
  end
end
