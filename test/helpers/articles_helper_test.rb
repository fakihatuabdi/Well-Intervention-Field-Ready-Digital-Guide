require "test_helper"

class ArticlesHelperTest < ActionView::TestCase
  test "handbook images become figures with captions" do
    html = ArticlesHelper.render_markdown("![Skematik BOP](/handbook-images/skematik-bop-kelas-3.webp)")[:html]
    assert_includes html, '<figure class="article-figure">'
    assert_includes html, 'loading="lazy"'
    assert_includes html, "<figcaption>Skematik BOP</figcaption>"
  end

  test "images from other places are removed" do
    html = ArticlesHelper.render_markdown("![x](https://evil.example/a.png) ![y](javascript:alert(1))")[:html]
    assert_not_includes html, "<img"
  end

  test "every image used in the handbook exists" do
    missing = Dir.glob(Rails.root.join("db/handbook/**/*.md")).flat_map do |path|
      File.read(path).scan(%r{\]\((/handbook-images/[^)\s]+)\)}).flatten
        .reject { |src| File.exist?(Rails.root.join("public#{src}")) }
        .map { |src| "#{File.basename(path)}: #{src}" }
    end
    assert_empty missing
  end

  test "excerpts do not show image markup" do
    assert_equal "Teks awal.", ArticlesHelper.plain_text("![gambar](/handbook-images/a.webp) Teks awal.")
  end
end
