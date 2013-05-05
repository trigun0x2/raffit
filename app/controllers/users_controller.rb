class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      user = login(params[:email], params[:password])
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def show
    if params[:id] == current_user.id.to_s
      redirect_to profile_path
    end
    @user = User.find(params[:id])
    @rep = Rep.sum(:vote, :conditions => {:user_id => @user.id}) + 1000
  end

  def profile
    @user = User.find(current_user.id)
    @rep = Rep.sum(:vote, :conditions => {:user_id => @user.id}) + 1000
  end

  def rate
    user_id = params[:user_id]
    rating = params[:rating]
    entry = Rep.where(:voter_id => current_user.id, :user_id => user_id)
    if entry.length == 0
      add = Rep.new(:voter_id => current_user.id, :user_id => user_id, :vote => rating)
      add.save
    else
      entry[0].update_attributes(:vote => rating)
      entry[0].save!
    end
  end
  
end
