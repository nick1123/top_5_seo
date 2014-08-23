class PostsController < ApplicationController
  def index
    category = params[:category] || Category::SEO
    @title = Category::CATEGORY_INFO[category][:title]
    @week = {}
    @week["Last 24 Hours"] = CategoryPost.includes(:post).where(category: category).where(created_at: (24.hours.ago..Time.now)).order("points DESC, created_at DESC")
    (1..6).each do |days_back|
      day = Date.current - days_back
      day_display = day.strftime("%A %B %-d, %Y")
      category_posts = CategoryPost.includes(:post).where(category: category).where(on_date: day).order("points DESC, created_at DESC")
      @week[day_display] = category_posts if category_posts.count > 0
    end
  end

  def url_redirect
    cp = CategoryPost.find(params[:cp_id])
    cp.increment_clicks(request.remote_ip)
    redirect_to cp.post.url
  end

  def vote_up
    cp = CategoryPost.find(params[:cp_id])
    cp.vote_up(request.remote_ip)
    redirect_to :root
  end

  def vote_down
    cp = CategoryPost.find(params[:cp_id])
    cp.vote_down(request.remote_ip)
    redirect_to :root
  end
end

