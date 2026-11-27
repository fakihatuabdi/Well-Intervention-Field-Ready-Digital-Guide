require "test_helper"

class UserTest < ActiveSupport::TestCase
  def build(attrs = {})
    User.new({ email: "new@example.com", password: "Password1234", password_confirmation: "Password1234" }.merge(attrs))
  end

  test "new accounts are read-only and pending by default" do
    user = build
    assert user.save
    assert_equal "pengguna", user.role
    assert user.pending?
    assert_not user.active_for_authentication?
  end

  test "passwords need 10 characters with letters and numbers" do
    assert_not build(password: "Short1", password_confirmation: "Short1").valid?
    assert_not build(password: "onlyletterspass", password_confirmation: "onlyletterspass").valid?
    assert build.valid?
  end

  test "role and status must be known values" do
    assert_not build(role: "superuser").valid?
    assert_not build(status: "whatever").valid?
  end

  test "e-mail is stored in lower case" do
    user = build(email: "  MiXeD@Example.COM ")
    user.save!
    assert_equal "mixed@example.com", user.email
  end
end
