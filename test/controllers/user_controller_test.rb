require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(username: "admin", email: "admin@mail.com", password: "password", admin: true)
    @existing_user = User.create(username: "existing", email: "existing@mail.com", password: "password")
  end

  test "admin user should be admin" do
    assert @admin.admin?
  end

  test "non admin user should not be admin" do
    assert_not @existing_user.admin?
  end
end