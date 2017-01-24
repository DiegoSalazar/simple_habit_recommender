class CreateSubTopics < ActiveRecord::Migration
  def change
    create_table :sub_topics do |t|
      t.string :subtopic_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
