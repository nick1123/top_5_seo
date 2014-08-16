require 'uri'
require 'feedjira'

desc "RSS Intake"
task :rss_intake => :environment do
  sleep_seconds = 3_600
  category = Post::CATEGORY_SEO

  while true do
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
            title:    title,
            url:      post_url,
            host:     host,
            category: category,
            on_date:  Date.today,
            points:   points
          )

          puts "  #{points} Points for #{title}"
        end
      rescue Exception => e
        puts e
        puts e.backtrace
      end
    end

    puts "Sleeping for #{sleep_seconds} seconds"
    sleep(sleep_seconds)
  end
end

def calculate_points(title)
  points = 0
  ['seo', 'link', 'panda', 'penguin', 'rank', 'serp'].each do |word|
    points += 1 if title.downcase.include?(word)
  end

  points = 1 if points > 1

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
