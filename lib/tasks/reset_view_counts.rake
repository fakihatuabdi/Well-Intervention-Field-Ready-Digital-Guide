namespace :articles do
  desc "Reset all article view counts to 0"
  task reset_view_counts: :environment do
    count = Article.update_all(view_count: 0)
    puts "Reset view counts of #{count} articles to 0."
  end
end
