class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :subtopic_id
      t.text :recommended_subtopic_ids

      t.timestamps
    end
  end
end
