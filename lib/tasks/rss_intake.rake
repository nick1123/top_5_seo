require 'uri'
require 'feedjira'

desc "RSS Intake"
task :rss_intake => :environment do
  urls = IO.readlines("lib/flat_files/rss_feeds.txt")
  urls[0..1].shuffle.each do |url|
    begin
    next if url.blank?
    url.strip!
    items = process_feed(url)
    puts items.inspect
    items.each do |item|
      Post.create(
        title:    item[:title],
        url:      item[:url],
        host:     URI.parse(item[:url]).host.gsub('www.', ''),
        category: Post::CATEGORY_SEO,
        on_date:  Date.today
      )
    end
    puts ''
    rescue Exception => e
      puts e
      puts e.backtrace
    end
  end
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
