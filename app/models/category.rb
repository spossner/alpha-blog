class Category < ActiveRecord::Base
  default_scope { order('name') }

  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum: 25}
end
