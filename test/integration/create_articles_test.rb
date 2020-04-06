require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(username: "admin", email: "admin@mail.com", password: "password", admin: true)
    @user = User.create(username: "user", email: "user@mail.com", password: "password")

    @sports = Category.create(name: "sports")
    @ruby = Category.create(name: "ruby")
  end

  test "unknown user can not create an article" do
    get new_article_path
    follow_redirect!
    assert_template 'pages/home'
    assert_match "You must be logged in", response.body
  end

  test "user can create an article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.all.count', 1 do
      post articles_path, params: { article: { title: "new article", description: "this is a new article by integration test", category_ids: [@sports.id, @ruby.id] } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "Successfully saved", response.body
  end
end