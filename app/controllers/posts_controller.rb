class PostsController < ApplicationController
  def index
    @posts = Post.where(created_at: (24.hours.ago..Time.now)).order("points DESC, created_at DESC")
  end

  def url_redirect
    post = Post.find(params[:post_id])
    post.increment_clicks
    redirect_to post.url
  end
end
