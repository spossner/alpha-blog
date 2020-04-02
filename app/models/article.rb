class Article < ApplicationRecord
  self.per_page = 5

  belongs_to :user

  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  validates :user_id,   presence: true
end
