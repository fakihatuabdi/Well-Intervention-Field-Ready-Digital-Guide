namespace :articles do
  desc "Reset all article view counts to 0 in database and Firebase"
  task reset_view_counts: :environment do
    puts "🔄 Resetting all article view counts to 0..."
    
    # Reset in Rails database
    Article.update_all(view_count: 0)
    total_articles = Article.count
    
    puts "✅ Reset #{total_articles} articles in database"
    puts "📊 Articles reset:"
    
    Article.all.each do |article|
      puts "   - #{article.title}: #{article.view_count} views"
    end
    
    puts "\n⚠️  Firebase Reset Instructions:"
    puts "To reset Firebase Realtime Database manually:"
    puts "1. Go to: https://console.firebase.google.com"
    puts "2. Select project: wi-field-ready-digital-guide"
    puts "3. Go to: Realtime Database"
    puts "4. Find 'article_views' node"
    puts "5. Click the 3 dots menu → Delete"
    puts "6. Confirm deletion"
    puts "\nOr delete specific articles by navigating to article_views/{article_id}"
    puts "\n✨ Done! All article view counts reset to 0 in database."
    puts "Note: Firebase will auto-sync when articles are viewed next time."
  end
end
