class DropIndexIndexSearchesOnQuery < ActiveRecord::Migration[6.0]
  def change
    remove_index :searches, name: "index_searches_on_query"
    add_index :searches, :query
  end
end
