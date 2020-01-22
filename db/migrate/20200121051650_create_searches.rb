class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :query, null: false
      t.timestamps
    end

    add_index :searches, :query, unique: true
  end
end
