class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.integer :clicks
      t.integer :votes
      t.integer :points

      t.timestamps
    end
  end
end
