# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :encrypted_password, presence: true
  validates :name, presence: true
end
