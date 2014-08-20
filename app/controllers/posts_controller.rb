class PostsController < ApplicationController
  def index
    min_points = (params[:all].present? ? -999999 : 1)
    @week = {}
    @week["Last 24 Hours"] = Post.where("points >= #{min_points}").where(created_at: (24.hours.ago..Time.now)).order("points DESC, created_at DESC")
    (1..6).each do |days_back|
      day = Date.current - days_back
      day_display = day.strftime("%A %B %-d, %Y")
      @week[day_display] = get_posts_for_day(day, min_points)
    end
  end

  def url_redirect
    post = Post.find(params[:post_id])
    post.increment_clicks(request.remote_ip)
    redirect_to post.url
  end

  def vote_up
    post = Post.find(params[:post_id])
    post.vote_up(request.remote_ip)
    redirect_to :root
  end

  def vote_down
    post = Post.find(params[:post_id])
    post.vote_down(request.remote_ip)
    redirect_to :root
  end

  private

  def get_posts_for_day(day, min_points)
    Post.where("points >= #{min_points}").where(on_date: day).order("points DESC, created_at DESC")
  end
end
