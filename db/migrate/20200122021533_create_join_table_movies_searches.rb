class CreateJoinTableMoviesSearches < ActiveRecord::Migration[6.0]
  def change
    create_join_table :movies, :searches do |t|
      t.index [:movie_id, :search_id]
      t.index [:search_id, :movie_id]
    end
  end
end
