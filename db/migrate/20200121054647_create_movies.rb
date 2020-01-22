class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.text :description
      t.references :search, null: false, foreign_key: true
      t.timestamps
    end
  end
end
