# frozen_string_literal: true

# class User
class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true, length: { maximum: 100 }
  validates :password_digest, presence: true
  validates :name, presence: true, length: { maximum: 50 }

  # Assign an API key on create
  before_create do |user|
    user.api_key = user.generate_api_key
  end

  # Generate a unique API key
  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'RST')
      break token unless User.exists?(api_key: token)
    end
  end
end
