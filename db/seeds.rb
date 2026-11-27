# Starter content for a fresh database.
#
# This file is safe to run on every deploy: it only creates records that are
# missing and NEVER deletes or overwrites existing data (articles edited by
# users, bookmarks, view counts, chat history all stay intact).

# Handbook articles (General Knowledge + Zona Rokan Operation) come from the
# Markdown files in db/handbook. The loader only adds or refreshes articles
# that nobody edited, and never deletes anything. A broken file must not stop
# the app from starting, so errors are reported and the seed continues.
puts "Loading handbook articles from db/handbook..."
begin
  result = HandbookContentLoader.load!(logger: $stdout)
  puts "Handbook: #{result}"
rescue HandbookContentLoader::InvalidFile, ActiveRecord::ActiveRecordError => e
  warn "Handbook content was NOT loaded: #{e.class}: #{e.message}"
  warn "Fix the file above, then run: bin/rails handbook:load"
end

# First administrator. Created only when no admin exists yet and both
# ADMIN_EMAIL and ADMIN_PASSWORD are set (docker-compose reads them from .env).
# An existing account is never changed here.
admin_email = ENV["ADMIN_EMAIL"].to_s.strip.downcase
admin_password = ENV["ADMIN_PASSWORD"].to_s
if User.admins.exists?
  puts "Admin account: already present (ADMIN_EMAIL/ADMIN_PASSWORD ignored)."
elsif admin_email.present? && admin_password.present?
  admin = User.find_or_initialize_by(email: admin_email)
  if admin.new_record?
    admin.assign_attributes(name: "Administrator", role: "admin", status: "active",
                            password: admin_password, password_confirmation: admin_password)
    if admin.save
      AuditEvent.record!("user.create", target: admin, details: { role: "admin", source: "seed" })
      puts "Admin account created: #{admin_email}"
    else
      warn "Admin account NOT created: #{admin.errors.full_messages.join(', ')}"
    end
  else
    warn "A non-admin account #{admin_email} already exists; make it admin with: bin/rails users:make_admin EMAIL=#{admin_email}"
  end
else
  warn "No admin account yet. Set ADMIN_EMAIL and ADMIN_PASSWORD, or run: bin/rails users:create_admin"
end

# Example case studies and notices, only when SEED_DEMO_CONTENT=true. Real
# installations start empty and admins add their own from the Admin page.
if AppSettings.flag("SEED_DEMO_CONTENT", false)
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
end

puts "Seed complete (existing data left untouched)."
puts "- #{Article.count} articles"
puts "- #{CaseStudy.count} case studies"
puts "- #{Update.count} updates"
puts "- #{User.count} users (#{User.admins.count} admin)"
