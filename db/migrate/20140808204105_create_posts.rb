class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.string  :url
      t.string  :host
      t.date    :on_date

      t.timestamps
    end

    add_index "posts", ["url"], :unique => true

    create_table :category_posts do |t|
      t.integer :post_id,    null: false
      t.string  :category,   null: false
      t.date    :on_date,    null: false
      t.integer :clicks,     default: 0
      t.integer :votes_up,   default: 0
      t.integer :votes_down, default: 0
      t.integer :points,     default: 0
      t.text    :voting_ip_addresses, default: ''
      t.text    :click_ip_addresses,  default: ''

      t.timestamps
    end

    add_index "category_posts", ["category", "post_id"], :unique => true
    add_index "category_posts", ["points"]
    add_index "category_posts", ["on_date"]
    add_index "category_posts", ["category"]
  end
end

