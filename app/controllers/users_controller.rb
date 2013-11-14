class UsersController < ApplicationController
	include SessionsHelper

	def index
    redirect_to root_url
  end

  def show
  end

  def new
    redirect_to @current_user if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      UserMailer.welcome_email(@user, request.env['HTTP_HOST']).deliver
      flash[:success] = t('signup.welcome', app_name: t('global.app_name'))
      redirect_to @user
    else
      render 'new'
    end
  end
end
