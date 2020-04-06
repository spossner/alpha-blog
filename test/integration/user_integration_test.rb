require 'test_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(username: "admin", email: "admin@mail.com", password: "password", admin: true)
    @existing_user = User.create(username: "existing", email: "existing@mail.com", password: "password")
  end

  test "already existing email can not be registered" do
    get new_user_path
    assert_template 'users/new'

    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "2nd existing", email: "existing@mail.com", password: "password" } }
    end
    assert_template 'users/new'
    assert_match "Email has already been taken", response.body
  end

  test "new customer can sign up" do
    get new_user_path
    assert_template 'users/new'

    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "New User", email: "new@mail.com", password: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "Welcome to Seppo&#39;s Blog", response.body
  end
end
