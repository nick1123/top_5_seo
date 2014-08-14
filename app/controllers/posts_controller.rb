class PostsController < ApplicationController
  def index
    #render plain: "OK"

    @posts = Post.order("points DESC, created_at DESC")
  end
end
