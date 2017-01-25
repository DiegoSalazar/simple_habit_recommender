class UsersController < ApplicationController
  def index
    @users = User.all.includes(:listens).page(params[:page]).per 20
  end

  def show
    @user = User.find params[:id]
  end
end
