require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "text color should be white on dark background" do
    assert_equal "#ffffff", contrast_color(0)
  end

  test "text color should be black on light background" do
    assert_equal "#000000", contrast_color(2)
  end
end

