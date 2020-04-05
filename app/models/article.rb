class Article < ApplicationRecord
  self.per_page = 5
  default_scope { order('created_at DESC') }

  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :user_id,   presence: true
end
