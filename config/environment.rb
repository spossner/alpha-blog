# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# prefer styling the div field_with_errors and use to optionally highlight the child elements
# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#   html_tag.html_safe
# end