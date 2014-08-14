class PostsController < ApplicationController
  def index
    @posts = Post.order("points DESC, created_at DESC")
  end
end
