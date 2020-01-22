class CleanupMovies < ActiveRecord::Migration[6.0]
  def change
    remove_reference :movies, :search
    remove_column :movies, :description, :text
  end
end
