# frozen_string_literal: true

module Api
  class UsersController < ApplicationController

    # GET /api/users
    def index
      @user = User.where(id: current_user.id).first

      unless @user
        render json: { error: { user_id: ['Not Found.'] } }, status: :not_found
      end
    end

    # GET /api/users/get_users
    def get_users
      @user = User.all

      render json: {data: @user}
    end

  end
end



