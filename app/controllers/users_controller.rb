class UsersController < ApplicationController

	def index
    redirect_to root_url
  end

  def show
  	@user = User.find(request[:id])
  end

  def new
    redirect_to @current_user if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
end
