require "will_paginate"

class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create

    @user = User.create(user_params)
    if @user.valid?
      token = JsonWebToken.encode({user_id: @user})
      render json: { user: @user, token: token}, status: :ok
    else
      render json: {error: "email and password"}, status: :unprocessable_entity
    end     

  end

  def show
    @user = User.find(params[:id])
    fresh_when etag: @user
    triggers = @user.triggers
    triggers = triggers.paginate(page: 1, per_page: 2)
    if params[:status]
      #byebug
      filter_triggers = User.find(params[:id]).triggers.where(status: params[:status]).paginate(page: 1, per_page: 2)
      render json: {triggers: filter_triggers,
      total_pages: triggers.total_pages,
      total_entries: triggers.total_entries}
    else
      render json: {triggers: triggers,
      total_pages: triggers.total_pages, 
      total_entries: triggers.total_entries}
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :user_name,:name, :password)

  end

end
