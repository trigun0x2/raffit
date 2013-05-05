class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    if params[:id] != current_user.id.to_s ######CHANGE TO ==
      redirect_to profile_path
    end
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(current_user.id)
  end
  
end
