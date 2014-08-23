desc "Categorize all posts"
task :categorize_all_posts => :environment do
  Post.all.each do |post|
    Category.categorize(post)
  end
end

