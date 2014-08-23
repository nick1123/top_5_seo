class Category
  ADSENSE            = 'adsense'
  ADWORDS            = 'adwords'
  FACEBOOK           = 'facebook'
  INTERNET_MARKETING = 'im'
  LINKED_IN          = 'linkedin'
  SEO                = 'seo'
  TWITTER            = 'twitter'


  CATEGORY_INFO = {
    ADSENSE            => {title: "Google AdSense"},
    ADWORDS            => {title: "Google AdWords"},
    FACEBOOK           => {title: "Facebook"},
    INTERNET_MARKETING => {title: "Internet Marketing"},
    LINKED_IN          => {title: "LinkedIn"},
    SEO                => {title: "Search Engine Optimization"},
    TWITTER            => {title: "Twitter"},
  }

  def self.categorize(post)
    add_category_post(post, INTERNET_MARKETING) # Always
    add_category_post(post, SEO)       if is_seo?(post)
    add_category_post(post, ADWORDS)   if is_adwords?(post)
    add_category_post(post, ADSENSE)   if is_adsense?(post)
    add_category_post(post, TWITTER)   if is_twitter?(post)
    add_category_post(post, LINKED_IN) if is_linked_in?(post)
    add_category_post(post, FACEBOOK)  if is_facebook?(post)
  end

  def self.is_facebook?(post)
    title = post.title.downcase
    return title.include?('facebook')
  end

  def self.is_linked_in?(post)
    title = post.title.downcase
    return (title.include?('linkedin') || title.include?('linkedin'))
  end

  def self.is_twitter?(post)
    title = post.title.downcase
    return title.include?('twitter')
  end

  def self.is_adsense?(post)
    title = post.title.downcase
    return title.include?('adsense')
  end

  def self.is_adwords?(post)
    title = post.title.downcase
    return title.include?('adwords')
  end

  def self.is_seo?(post)
    title = ' ' + post.title.downcase.gsub('linkedin', '') + ' '
    ['seo', 'link', 'panda', 'penguin', ' rank', 'serp'].each do |word|
      return true if title.include?(word)
    end

    return false
  end

  def self.add_category_post(post, category)
    if CategoryPost.where(post_id: post.id, category: category).count == 0
      CategoryPost.create(post_id: post.id, category: category, on_date: post.on_date)
    end
  end
end

