class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.integer :category
      t.integer :clicks
      t.integer :votes_up
      t.integer :votes_down
      t.integer :points
      t.text :voting_ip_addresses

      t.timestamps
    end

    add_index "posts", ["category", "url"], :unique => true
    add_index "posts", ["points"]
    add_index "posts", ["created_at"]
  end
end

