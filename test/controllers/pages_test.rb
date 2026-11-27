require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:reader) }

  %w[/ /home /handbook /handbook/general_knowledge /handbook/wk_rokan /handbook/rig_hub
     /search /calculator /bookmarks].each do |path|
    test "#{path} loads" do
      get path
      assert_response :success
    end
  end

  test "general knowledge lists only its own articles" do
    get "/handbook/general_knowledge"
    assert_includes response.body, "Packer"
    assert_not_includes response.body, "Draft Article"
  end

  test "published article renders markdown with a table of contents" do
    get article_path(articles(:gk_packer))
    assert_response :success
    assert_includes response.body, "Fungsi Packer"
    assert_includes response.body, "Materi umum oil &amp; gas"
  end

  test "zona rokan article shows the zona rokan notice" do
    get article_path(articles(:zr_pump))
    assert_includes response.body, "Khusus implementasi operasi di Zona Rokan"
  end

  test "unpublished article is not reachable" do
    get article_path(articles(:draft))
    assert_response :redirect
    get article_path(articles(:draft)), as: :json
    assert_response :not_found
  end

  test "search handles special characters" do
    get "/search", params: { query: "100% (pump_" }
    assert_response :success
    get "/search/suggestions", params: { query: "<script>" }
    assert_response :success
  end

  test "chat history page loads with saved messages when the chat bot is on" do
    with_env("CHAT_BOT_ENABLED" => "true") do
      post "/chat_bot/send_message", params: { message: "Apa itu packer?" }, as: :json
      assert_response :success
      get "/chat_bot"
      assert_response :success
    end
  end

  test "chat bot is off by default" do
    with_env("CHAT_BOT_ENABLED" => nil) do
      get "/chat_bot"
      assert_redirected_to root_path
      post "/chat_bot/send_message", params: { message: "hi" }, as: :json
      assert_response :not_found
      get "/"
      assert_not_includes response.body, %(href="/chat_bot")
    end
  end

  test "bookmarks of one visitor are not visible to another" do
    article = articles(:gk_packer)
    post bookmark_article_path(article), as: :json
    assert_equal 1, Bookmark.count
    get "/bookmarks"
    assert_includes response.body, "Packer"

    reset!
    sign_in users(:admin)
    get "/bookmarks"
    assert_not_includes response.body, "Fungsi dan jenis packer"
    delete bookmark_path(Bookmark.first)
    assert_equal 1, Bookmark.count
  end
end
