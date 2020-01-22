class CleanupMovies < ActiveRecord::Migration[6.0]
  def change
    remove_reference :movies, :search
  end
end
