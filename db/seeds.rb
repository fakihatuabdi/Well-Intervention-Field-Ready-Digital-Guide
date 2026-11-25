# Starter content for a fresh database.
#
# This file is safe to run on every deploy: it only creates records that are
# missing and NEVER deletes or overwrites existing data (articles edited by
# users, bookmarks, view counts, chat history all stay intact).

puts "Ensuring starter articles exist..."

# General Knowledge Articles
comprehensive_content = <<~CONTENT
  📚 Comprehensive Content in Development

  We're meticulously crafting detailed, field-tested content for this section to ensure the highest quality and accuracy for our well intervention professionals.
  
  ⏳ What to Expect:
  • In-depth technical guidelines and procedures
  • Real-world case studies and best practices
  • Step-by-step operational instructions
  • Safety protocols and quality standards
  • Expert insights from industry veterans

  This content is currently under review by our technical team and subject matter experts to deliver the most valuable and practical information for your field operations.
  
  🔔 Stay tuned for updates — quality content takes time, and we're committed to excellence.

  Thank you for your patience as we build the most comprehensive well intervention resource for field professionals.
CONTENT

general_knowledge_articles = [
  { title: "Abbreviation", category: "general_knowledge", content: comprehensive_content },
  { title: "Drilling & Well Intervention Safety", category: "general_knowledge", content: comprehensive_content },
  { title: "HSSE Rig Operation", category: "general_knowledge", content: comprehensive_content },
  { title: "Rig Unit", category: "general_knowledge", content: comprehensive_content },
  { title: "Pre-Well Intervention Execution", category: "general_knowledge", content: comprehensive_content },
  { title: "Well Intervention Operation", category: "general_knowledge", content: comprehensive_content },
  { title: "Well Problem Handling", category: "general_knowledge", content: comprehensive_content },
  { title: "Packer", category: "general_knowledge", content: comprehensive_content },
  { title: "Well Head", category: "general_knowledge", content: comprehensive_content },
  { title: "Well Completion", category: "general_knowledge", content: comprehensive_content },
  { title: "Artificial Lift", category: "general_knowledge", content: comprehensive_content },
  { title: "Glossary", category: "general_knowledge", content: comprehensive_content }
]

general_knowledge_articles.each do |article_data|
  Article.find_or_create_by!(title: article_data[:title], category: article_data[:category], subcategory: nil) do |article|
    article.content = article_data[:content]
    article.published = true
    article.view_count = 0
  end
end

# Zona Rokan - Rig Hub Articles
rig_hub_articles = [
  { title: "Objective", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Rig Hub Introduction", subcategory: "rig_hub", content: comprehensive_content },
  { title: "On-Boarding Process", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Sumatera Operation Area", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Artificial Lift", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Heavy Oil Best Practice", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Light Oil Best Practice", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Special Operation", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Simultaneous Operations (SIMOPS)", subcategory: "rig_hub", content: comprehensive_content },
  { title: "Appendix", subcategory: "rig_hub", content: comprehensive_content }
]

rig_hub_articles.each do |article_data|
  Article.find_or_create_by!(title: article_data[:title], category: "zona_rokan", subcategory: article_data[:subcategory]) do |article|
    article.content = article_data[:content]
    article.published = true
    article.view_count = 0
  end
end

puts "Creating case studies..."

case_studies = [
  {
    title: "Successful Heavy Oil Recovery in Block A",
    description: "Implementation of innovative heavy oil recovery techniques resulted in 35% production increase.",
    content: "Detailed case study content here...",
    published: true
  },
  {
    title: "SIMOPS Excellence in Multi-Well Project",
    description: "Safe and efficient simultaneous operations across multiple wells with zero incidents.",
    content: "Detailed case study content here...",
    published: true
  },
  {
    title: "Rapid Response to Well Control Incident",
    description: "Quick thinking and proper procedures prevented major well control incident.",
    content: "Detailed case study content here...",
    published: true
  }
]

case_studies.each do |cs_data|
  CaseStudy.find_or_create_by!(title: cs_data[:title]) do |case_study|
    case_study.assign_attributes(cs_data.except(:title))
  end
end

puts "Creating updates and notices..."

updates = [
  {
    title: "New Safety Protocol Implementation",
    content: "Updated HSSE guidelines now in effect for all rig operations. Please review the updated handbook section.",
    published_at: 2.days.ago,
    category: "safety"
  },
  {
    title: "Rig Hub Expansion Announcement",
    content: "New divisions for Rig Hub operations will be added Q2 2026. Training programs coming soon.",
    published_at: 5.days.ago,
    category: "announcement"
  },
  {
    title: "Monthly Operations Review",
    content: "December operations summary and best practices identified. Check the latest case studies.",
    published_at: 7.days.ago,
    category: "review"
  },
  {
    title: "Calculator Tools Beta Launch",
    content: "Beta testing for new calculation tools starting next month. Sign up for early access.",
    published_at: 10.days.ago,
    category: "feature"
  },
  {
    title: "AI Chat Bot Development Update",
    content: "AI-powered chat assistance progressing well. Expected launch in Q3 2026.",
    published_at: 14.days.ago,
    category: "feature"
  }
]

updates.each do |update_data|
  Update.find_or_create_by!(title: update_data[:title]) do |update|
    update.assign_attributes(update_data.except(:title))
  end
end

puts "Seed complete (existing data left untouched)."
puts "- #{Article.count} articles"
puts "- #{CaseStudy.count} case studies"
puts "- #{Update.count} updates"
