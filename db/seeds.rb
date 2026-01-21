# Clear existing data
puts "Clearing existing data..."
Article.destroy_all
CaseStudy.destroy_all
Update.destroy_all
Bookmark.destroy_all

puts "Creating sample articles..."

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
  Article.create!(
    title: article_data[:title],
    category: article_data[:category],
    content: article_data[:content],
    published: true,
    view_count: rand(10..500)
  )
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
  Article.create!(
    title: article_data[:title],
    category: "zona_rokan",
    subcategory: article_data[:subcategory],
    content: article_data[:content],
    published: true,
    view_count: rand(10..300)
  )
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
  CaseStudy.create!(cs_data)
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
  Update.create!(update_data)
end

puts "Seed data created successfully!"
puts "- #{Article.count} articles"
puts "- #{CaseStudy.count} case studies"
puts "- #{Update.count} updates"
