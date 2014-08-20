class Post < ActiveRecord::Base
  CATEGORY_SEO = 1
  def increment_clicks(remote_ip)
    self.clicks += 1

    if !self.click_ip_addresses.to_s.include?(remote_ip)
      self.click_ip_addresses = self.click_ip_addresses.to_s + remote_ip + ' '
      self.points += 1
    end

    self.save
  end
end
