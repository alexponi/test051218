# frozen_string_literal: true
require 'bcrypt'

class UsersController < ApplicationController
  def index
    users = User.all
    render json: users, head: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { user_id: user.id }, status: :ok
    else
      head :conflict
    end
  end

  def show
    user = User.find(params[:id])
    render json: user, head: :ok
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
end
