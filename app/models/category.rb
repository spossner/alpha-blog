class Category < ActiveRecord::Base
  default_scope { order('name') }

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 25}
end
