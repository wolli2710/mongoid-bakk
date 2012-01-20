class UsersController < ApplicationController

  def index
    @users = User.list_all_users
  end

  def new
    @user = User.new
  end

  def create
    user = User.create_new_user params[:user][:first_name], params[:user][:last_name],
                      params[:user][:e_mail]
    if user.valid?
      flash[:message] = "New user created"
      redirect_to users_path
    else
      flash[:warning] = "Failed to save user"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.get_user params[:id]
  end

  def destroy
    User.delete_user(params[:id])
    redirect_to users_path
  end

  def delete_users
    User.delete_users
    redirect_to users_path
  end

  def follow
    @user = User.get_user params[:uid]
    @follow = User.get_user params[:follow]
    @user.follow!(@follow)
    redirect_to users_path
  end

  def timeline
    @user = User.get_user params[:id]
  end

end
