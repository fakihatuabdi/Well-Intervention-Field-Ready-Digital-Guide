namespace :articles do
  desc "Update article content with coming soon message"
  task update_empty_content: :environment do
    coming_soon_text = %{📚 Comprehensive Content in Development

We're meticulously crafting detailed, field-tested content for this section to ensure the highest quality and accuracy for our well intervention professionals.

⏳ What to Expect:
• In-depth technical guidelines and procedures
• Real-world case studies and best practices  
• Step-by-step operational instructions
• Safety protocols and quality standards
• Expert insights from industry veterans

This content is currently under review by our technical team and subject matter experts to deliver the most valuable and practical information for your field operations.

🔔 Stay tuned for updates — quality content takes time, and we're committed to excellence.

Thank you for your patience as we build the most comprehensive well intervention resource for field professionals.}

    updated_count = 0
    Article.find_each do |article|
      if article.content.to_s.length < 200
        article.update(content: coming_soon_text)
        puts "✓ Updated: #{article.title}"
        updated_count += 1
      end
    end
    
    puts "\n#{updated_count} articles updated with coming soon content."
  end
end
