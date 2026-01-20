namespace :firebase do
  desc "Reset Firebase view counters to zero"
  task reset_views: :environment do
    puts "🔥 Firebase View Counter Reset Task"
    puts "=" * 50
    
    # Get all article IDs
    article_ids = Article.pluck(:id)
    
    puts "\nFound #{article_ids.count} articles"
    puts "This task will show you the Firebase Database paths to reset manually."
    puts "\nTo reset view counters, you need to:"
    puts "1. Open Firebase Console: https://console.firebase.google.com"
    puts "2. Go to Realtime Database"
    puts "3. Navigate to 'article_views' node"
    puts "4. Delete the entire 'article_views' node or individual article IDs"
    puts "\nArticle IDs in database:"
    article_ids.each_slice(5) do |ids|
      puts "  - #{ids.join(', ')}"
    end
    
    puts "\nFirebase paths to delete:"
    puts "  - /article_views (delete all)"
    article_ids.first(5).each do |id|
      puts "  - /article_views/#{id} (individual)"
    end
    puts "  - ... and more"
    
    puts "\n✅ After deleting, view counters will start from 0 again"
  end

  desc "Reset Rails database view counters to zero"
  task reset_rails_views: :environment do
    puts "🔄 Resetting Rails Database View Counters..."
    
    updated_count = Article.update_all(view_count: 0)
    
    puts "✅ Reset #{updated_count} articles view_count to 0"
    puts "\nNote: This only resets Rails database."
    puts "To reset Firebase counters, run: rake firebase:reset_views"
  end

  desc "Sync Firebase view counts to Rails database"
  task sync_views_to_rails: :environment do
    puts "⚠️  This task requires Firebase Admin SDK setup"
    puts "Currently not implemented - manual sync only"
    puts "\nTo sync manually:"
    puts "1. Open Firebase Console"
    puts "2. Export article_views data"
    puts "3. Update Rails records manually"
  end
end
