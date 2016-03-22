class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "Profile updated sucessfully!"
    else
      render 'edit'
      flash[:notice] = "Something went wrong!"
    end
  end

  def show
  end

  def follow
    @follower = current_user.active_relationships.build(followed_id: params[:id] )
    if @follower.save
      flash[:notice] = "You are following this user now!"
    else
      flash[:notice] = "Something went wrong!"
    end
    redirect_to user_path(params[:id])
  end

  def unfollow
    if current_user.active_relationships.find_by(followed_id: params[:id]).destroy
      flash[:notice] = "You are unfollowing this user now!"
    end
    redirect_to user_path(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:fname, :lname, :dob, :gender, :avatar)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
