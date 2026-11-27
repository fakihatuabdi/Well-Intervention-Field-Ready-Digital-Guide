require "test_helper"

class HandbookContentLoaderTest < ActiveSupport::TestCase
  setup do
    @dir = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(@dir, "general_knowledge"))
    FileUtils.mkdir_p(File.join(@dir, "zona_rokan"))
  end

  teardown { FileUtils.rm_rf(@dir) }

  def write(folder, name, body)
    File.write(File.join(@dir, folder, name), body)
  end

  def article_file(title:, slug:, body: "## Isi\n\nKonten.")
    "---\ntitle: #{title}\nslug: #{slug}\nposition: 1\nsummary: Ringkasan\n---\n#{body}\n"
  end

  test "the real handbook files are valid" do
    entries = HandbookContentLoader.new.entries
    assert_operator entries.size, :>=, 20
    assert entries.all? { |e| e.slug.start_with?("gk-", "zr-") }
  end

  test "loading twice is idempotent" do
    write("general_knowledge", "a.md", article_file(title: "Baru", slug: "gk-baru"))
    first = HandbookContentLoader.load!(root: @dir)
    second = HandbookContentLoader.load!(root: @dir)
    assert_equal ["Baru"], first.created
    assert_equal ["Baru"], second.unchanged
  end

  test "replaces a placeholder and keeps its view count" do
    old = Article.create!(title: "Wellhead", category: "general_knowledge", content: "Content will be added soon", published: true, view_count: 9)
    write("general_knowledge", "a.md", article_file(title: "Wellhead", slug: "gk-wellhead"))
    result = HandbookContentLoader.load!(root: @dir)
    assert_equal ["Wellhead"], result.updated
    old.reload
    assert_equal "gk-wellhead", old.slug
    assert_equal 9, old.view_count
  end

  test "never overwrites an article a user edited" do
    write("general_knowledge", "a.md", article_file(title: "Baru", slug: "gk-baru"))
    HandbookContentLoader.load!(root: @dir)
    Article.find_by(slug: "gk-baru").update!(content: "Diedit admin")
    write("general_knowledge", "a.md", article_file(title: "Baru", slug: "gk-baru", body: "Versi baru"))
    result = HandbookContentLoader.load!(root: @dir)
    assert_equal ["Baru"], result.skipped
    assert_equal "Diedit admin", Article.find_by(slug: "gk-baru").content
  end

  test "broken file is reported before anything is written" do
    write("general_knowledge", "a.md", article_file(title: "Satu", slug: "gk-satu"))
    write("general_knowledge", "b.md", "no front matter")
    assert_no_difference("Article.count") do
      assert_raises(HandbookContentLoader::InvalidFile) { HandbookContentLoader.load!(root: @dir) }
    end
  end
end
