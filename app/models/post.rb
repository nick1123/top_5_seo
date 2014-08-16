class Post < ActiveRecord::Base
  CATEGORY_SEO = 1
  def increment_clicks
    self.clicks += 1
    self.points += 1
    self.save
  end
end
