# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 }
  validates :password_digest, presence: true
  validates :name, presence: true, length: { maximum: 50 }
end
