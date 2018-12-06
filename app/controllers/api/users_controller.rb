# frozen_string_literal: true
require 'bcrypt'

module Api
  class UsersController < ApplicationController
    def create
      user = User.create(user_params)
      if user.save
        render json: { user_id: user.id }, status: :ok
      else
        head :conflict
      end
    end

    private

    def user_params
      params.permit(:email, :password, :name)
    end
  end
end
