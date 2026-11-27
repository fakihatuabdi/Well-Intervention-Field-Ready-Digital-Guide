namespace :handbook do
  desc "Load or refresh handbook articles from db/handbook (safe to run many times)"
  task load: :environment do
    result = HandbookContentLoader.load!(logger: $stdout)
    puts result
  end

  desc "Check the handbook Markdown files without touching the database"
  task check: :environment do
    entries = HandbookContentLoader.new.entries
    entries.group_by(&:category).each do |category, items|
      puts "#{category}: #{items.size} articles"
      items.sort_by(&:position).each { |e| puts "  #{e.position.to_s.rjust(2)}. #{e.title} (#{e.slug})" }
    end
  end
end
