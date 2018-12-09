# frozen_string_literal: true

# Add Api key to table 'users'
class AddApiKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :api_key, :string
  end
end
