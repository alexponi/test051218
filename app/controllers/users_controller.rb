# frozen_string_literal: true
require 'bcrypt'

class UsersController < ApplicationController

  def index
    @users = User.all
    render json: json_string = UserSerializer.new(@users).serialized_json
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { data: { id: @user.id, key: @user.api_key } }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    begin
      @user = User.find(params[:id])
      render json: json_string = UserSerializer.new(@user).serialized_json
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
end
