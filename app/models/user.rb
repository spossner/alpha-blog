class User < ApplicationRecord
  default_scope { order('username') }

  has_many :articles, dependent: :destroy

  before_save { self.email = email.downcase }

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i }

  has_secure_password
end
