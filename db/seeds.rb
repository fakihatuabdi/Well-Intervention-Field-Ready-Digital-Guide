# Clear existing data
puts "Clearing existing data..."
Article.destroy_all
CaseStudy.destroy_all
Update.destroy_all
Bookmark.destroy_all

puts "Creating sample articles..."

# General Knowledge Articles
general_knowledge_articles = [
  { title: "Abbreviation", category: "general_knowledge", content: "Common abbreviations used in well intervention operations will be listed here." },
  { title: "Drilling & Well Intervention Safety", category: "general_knowledge", content: "Safety procedures and protocols for drilling and well intervention operations." },
  { title: "HSSE Rig Operation", category: "general_knowledge", content: "Health, Safety, Security, and Environment guidelines for rig operations." },
  { title: "Rig Unit", category: "general_knowledge", content: "Overview of rig unit components and operations." },
  { title: "Pre-Well Intervention Execution", category: "general_knowledge", content: "Planning and preparation steps before well intervention execution." },
  { title: "Well Intervention Operation", category: "general_knowledge", content: "Standard operating procedures for well intervention operations." },
  { title: "Well Problem Handling", category: "general_knowledge", content: "Troubleshooting and problem-solving techniques for well issues." },
  { title: "Packer", category: "general_knowledge", content: "Types, installation, and operation of packers in well systems." },
  { title: "Well Head", category: "general_knowledge", content: "Well head components, assembly, and maintenance procedures." },
  { title: "Well Completion", category: "general_knowledge", content: "Well completion techniques and best practices." },
  { title: "Artificial Lift", category: "general_knowledge", content: "Various artificial lift methods and their applications." },
  { title: "Glossary", category: "general_knowledge", content: "Comprehensive glossary of well intervention terminology." }
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

# WK Rokan - Rig Hub Articles
rig_hub_articles = [
  { title: "Objective", subcategory: "rig_hub", content: "Objectives and goals of the Rig Hub operations in WK Rokan field." },
  { title: "Rig Hub Introduction", subcategory: "rig_hub", content: "Introduction to Rig Hub operations, structure, and organization." },
  { title: "On-Boarding Process", subcategory: "rig_hub", content: "Step-by-step on-boarding process for new personnel joining Rig Hub operations." },
  { title: "Sumatera Operation Area", subcategory: "rig_hub", content: "Overview of operational areas in Sumatera region for Rig Hub operations." },
  { title: "Artificial Lift", subcategory: "rig_hub", content: "Artificial lift systems specifically used in Rig Hub operations." },
  { title: "Heavy Oil Best Practice", subcategory: "rig_hub", content: "Best practices for handling and processing heavy oil in Rig Hub operations." },
  { title: "Light Oil Best Practice", subcategory: "rig_hub", content: "Best practices for handling and processing light oil in Rig Hub operations." },
  { title: "Special Operation", subcategory: "rig_hub", content: "Special operational procedures and requirements for unique situations." },
  { title: "Simultaneous Operations (SIMOPS)", subcategory: "rig_hub", content: "Guidelines and safety protocols for simultaneous operations." },
  { title: "Appendix", subcategory: "rig_hub", content: "Additional reference materials, forms, and documentation for Rig Hub operations." }
]

rig_hub_articles.each do |article_data|
  Article.create!(
    title: article_data[:title],
    category: "wk_rokan",
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
