class CreateListens < ActiveRecord::Migration
  def change
    create_table :listens do |t|
      t.string :user_id
      t.datetime :listen_date
      t.string :subtopic_id

      t.timestamps
    end
  end
end
