require 'uri'
require 'feedjira'

desc "RSS Intake"
task :rss_intake => :environment do
  sleep_seconds = 3_600
  category = Post::CATEGORY_SEO

  urls = IO.readlines("lib/flat_files/rss_feeds.txt")
  urls.shuffle.each do |url|
    begin
      next if url.blank?
      url.strip!
      puts "Processing feed: #{url}"

      items = process_feed(url)
      items.each do |item|
        post_url = item[:url]
        next if Post.where(url: post_url, category: category).count > 0

        title = item[:title]
        points = calculate_points(title)

        host = URI.parse(post_url).host.gsub('www.', '')
        Post.create(
          title:    item[:title],
          url:      post_url,
          host:     host,
          category: category,
          on_date:  Date.today,
          points:   points
        )

        puts "  #{points} Points for #{post_url}"
      end
    rescue Exception => e
      puts e
      puts e.backtrace
    end
  end

  puts "Sleeping for #{sleep_seconds} seconds"
  sleep(sleep_seconds)
end

def calculate_points(title)
  points = 0
  if title.downcase.include?('seo')
    points += 1
  end

  return points
end

def process_feed(rss_url)
  feed = Feedjira::Feed.fetch_and_parse(rss_url)

  ret = []
  feed.entries.each do |entry|
    ret << process_entry(entry)
  end

  return ret
end

def process_entry(entry)
  {
    title:     entry.title,
    url:       entry.url,
    published: entry.published
  }
end
