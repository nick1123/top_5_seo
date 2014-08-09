class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :host
      t.integer :category
      t.integer :clicks,     default: 0
      t.integer :votes_up,   default: 0
      t.integer :votes_down, default: 0
      t.integer :points,     default: 0
      t.text :voting_ip_addresses
      t.date :on_date

      t.timestamps
    end

    add_index "posts", ["category", "url"], :unique => true
    add_index "posts", ["points"]
    add_index "posts", ["created_at"]
  end
end

