require 'feedjira'

desc "RSS Intake"
task :rss_intake => :environment do
  urls = IO.readlines("lib/flat_files/rss_feeds.txt")
  urls.shuffle.each do |url|
    begin
    next if url.blank?
    url.strip!
    items = process_feed(url)
    puts items.inspect
    puts ''
    rescue Exception => e
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
