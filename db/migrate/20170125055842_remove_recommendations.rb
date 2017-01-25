class RemoveRecommendations < ActiveRecord::Migration
  def change
    drop_table :recommendations if table_exists? :recommendations
  end
end
