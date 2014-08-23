class CategoryPost < ActiveRecord::Base

  belongs_to :post

  POINTS_PER_VOTE = 10

  def increment_clicks(remote_ip)
    self.clicks += 1

#    if !self.click_ip_addresses.to_s.include?(remote_ip)
#      self.click_ip_addresses = self.click_ip_addresses.to_s + remote_ip + ' '
#      self.points += 1
#    end

    self.points += 1
    self.save
  end

  def vote_up(remote_ip)
    self.votes_up += 1
#    if !voted_before?(remote_ip)
#      record_vote_ip(remote_ip)
#      self.points += POINTS_PER_VOTE
#    end

    self.points += POINTS_PER_VOTE
    self.save
  end

  def vote_down(remote_ip)
    self.votes_down += 1
#    if !voted_before?(remote_ip)
#      record_vote_ip(remote_ip)
#      self.points -= POINTS_PER_VOTE
#    end

    self.points -= POINTS_PER_VOTE
    self.save
  end

  def voted_before?(remote_ip)
    self.voting_ip_addresses.to_s.include?(remote_ip)
  end

  def record_vote_ip(remote_ip)
    self.voting_ip_addresses = self.voting_ip_addresses.to_s + remote_ip + ' '
  end
end
