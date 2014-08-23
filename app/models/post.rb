class Post < ActiveRecord::Base
  has_many :category_posts
end
