class PostsController < ApplicationController
  def index
    @posts = Post.where(created_at: (24.hours.ago..Time.now)).order("points DESC, created_at DESC")
  end
end
