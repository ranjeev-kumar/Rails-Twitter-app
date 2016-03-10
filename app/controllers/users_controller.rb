class UsersController < ApplicationController
  
  def index
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to @user
		else
			render 'edit'
		end
	end

  def show
  	@user = User.find(params[:id])
  end

  def follow
  	@follower = current_user.active_relationships.build(followed_id: params[:id] )
  	@follower.save
  	redirect_to user_path(params[:id])
  end

  def unfollow
  	current_user.active_relationships.find_by(followed_id: params[:id]).destroy
  	redirect_to user_path(params[:id])
  end

  private
	def user_params
		params.require(:user).permit(:fname, :lname, :dob, :gender, :avatar)
	end


end
