require "test_helper"

class AccessControlTest < ActionDispatch::IntegrationTest
  test "visitors must sign in by default" do
    with_env("REQUIRE_LOGIN" => nil) do
      get "/handbook"
      assert_redirected_to new_user_session_path
      get article_path(articles(:gk_packer)), as: :json
      assert_response :unauthorized
    end
  end

  test "the health check works without signing in" do
    get "/up"
    assert_response :success
  end

  test "REQUIRE_LOGIN=false lets visitors read but not open the admin area" do
    with_env("REQUIRE_LOGIN" => "false") do
      get "/handbook"
      assert_response :success
      get "/admin"
      assert_redirected_to new_user_session_path
    end
  end

  test "a pengguna cannot open or change anything in the admin area" do
    sign_in users(:reader)
    get "/admin"
    assert_redirected_to root_path
    patch admin_article_path(articles(:gk_packer)), params: { article: { title: "Hacked" } }
    assert_redirected_to root_path
    assert_equal "Packer", articles(:gk_packer).reload.title
    post admin_users_path, params: { user: { email: "x@example.com", role: "admin", password: "Password1234" } }
    assert_nil User.find_by(email: "x@example.com")
  end

  test "an admin edits an article and the change is in the audit log" do
    sign_in users(:admin)
    article = articles(:gk_packer)
    patch admin_article_path(article), params: { article: { title: "Packer (rev)", content: "## Baru\nIsi baru" } }
    assert_redirected_to edit_admin_article_path(article)
    assert_equal "Packer (rev)", article.reload.title
    event = AuditEvent.last
    assert_equal "article.update", event.action
    assert_equal users(:admin).email, event.actor_email
    get admin_audit_events_path
    assert_response :success
  end

  test "an admin creates an account and approves a pending one" do
    sign_in users(:admin)
    post admin_users_path, params: { user: { name: "Baru", email: "Baru@Example.com", role: "pengguna", status: "active",
                                             password: "Password1234", password_confirmation: "Password1234" } }
    assert_redirected_to admin_users_path
    assert User.find_by(email: "baru@example.com").active?

    patch approve_admin_user_path(users(:pending))
    assert users(:pending).reload.active?
  end

  test "the last active admin cannot remove their own admin rights" do
    sign_in users(:admin)
    patch admin_user_path(users(:admin)), params: { user: { role: "pengguna" } }
    assert_response :unprocessable_entity
    assert users(:admin).reload.admin?
  end

  test "admin pages load" do
    sign_in users(:admin)
    [admin_root_path, admin_articles_path, new_admin_article_path, edit_admin_article_path(articles(:gk_packer)),
     admin_updates_path, new_admin_update_path, admin_case_studies_path, new_admin_case_study_path,
     admin_users_path, new_admin_user_path, edit_admin_user_path(users(:reader)), admin_audit_events_path].each do |path|
      get path
      assert_response :success, path
    end
  end

  test "pending and disabled accounts cannot sign in" do
    post user_session_path, params: { user: { email: "pending@example.com", password: "Password1234" } }
    follow_redirect!
    assert_includes response.body, "waiting for approval"

    users(:reader).update!(status: "disabled")
    post user_session_path, params: { user: { email: "reader@example.com", password: "Password1234" } }
    get "/handbook"
    assert_redirected_to new_user_session_path
  end

  test "sign-in success and failure are recorded" do
    post user_session_path, params: { user: { email: "reader@example.com", password: "wrong-password1" } }
    assert_equal "user.sign_in_failed", AuditEvent.last.action
    assert_not_includes AuditEvent.last.details, "wrong-password1"

    post user_session_path, params: { user: { email: "reader@example.com", password: "Password1234" } }
    assert_equal "user.sign_in", AuditEvent.last.action
  end

  test "an account locks after 5 wrong passwords" do
    5.times { post user_session_path, params: { user: { email: "reader@example.com", password: "wrong-password1" } } }
    assert users(:reader).reload.access_locked?
    post user_session_path, params: { user: { email: "reader@example.com", password: "Password1234" } }
    get "/handbook"
    assert_redirected_to new_user_session_path
  end

  test "self sign-up is off by default" do
    with_env("ALLOW_SIGNUP" => nil) do
      get new_user_registration_path
      assert_redirected_to new_user_session_path
      post user_registration_path, params: { user: { email: "a@example.com", password: "Password1234", password_confirmation: "Password1234" } }
      assert_nil User.find_by(email: "a@example.com")
    end
  end

  test "self sign-up only accepts the company domain and waits for approval" do
    with_env("ALLOW_SIGNUP" => "true", "SIGNUP_EMAIL_DOMAIN" => "company.co.id") do
      post user_registration_path, params: { user: { name: "Luar", email: "luar@gmail.com", password: "Password1234", password_confirmation: "Password1234" } }
      assert_nil User.find_by(email: "luar@gmail.com")

      post user_registration_path, params: { user: { name: "Dalam", email: "dalam@company.co.id", password: "Password1234",
                                                      password_confirmation: "Password1234", role: "admin", status: "active" } }
      user = User.find_by(email: "dalam@company.co.id")
      assert user, "account should be created"
      assert_equal "pengguna", user.role
      assert user.pending?
      get "/handbook"
      assert_redirected_to new_user_session_path
    end
  end

  test "users can change their own password but not their role" do
    sign_in users(:reader)
    put user_registration_path, params: { user: { name: "Nama Baru", role: "admin", current_password: "Password1234" } }
    users(:reader).reload
    assert_equal "Nama Baru", users(:reader).name
    assert_not users(:reader).admin?
  end

  test "pages send a strict content security policy and load nothing from the internet" do
    sign_in users(:reader)
    get "/"
    csp = response.headers["Content-Security-Policy"]
    assert_includes csp, "script-src 'self' 'nonce-"
    assert_includes csp, "object-src 'none'"
    assert_no_match %r{<(script|link)[^>]+(src|href)="https?://}, response.body
  end

  test "the script nonce stays the same between pages of one visit (needed by Turbo)" do
    with_env("REQUIRE_LOGIN" => "false") do
      get "/handbook"
      first = response.headers["Content-Security-Policy"][/nonce-([^']+)/, 1]
      get "/search"
      assert_equal first, response.headers["Content-Security-Policy"][/nonce-([^']+)/, 1]
    end
  end

  test "signing out returns to the sign-in page" do
    sign_in users(:reader)
    delete destroy_user_session_path
    assert_redirected_to new_user_session_path
  end
end
