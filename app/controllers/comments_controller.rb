class CommentsController < ApplicationController

	def index
		@comments = Comment.all
	end

	def new
		@comment = Comment.new
	end

	def edit
		@tweet = Tweet.find(params[:tweet_id])
		@comment = Comment.find(params[:id])
	end

	def create
		@tweet = Tweet.find(params[:tweet_id])
		@comment = @tweet.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to tweets_path(@tweet)
		else
			redirect_to tweets_path(@tweet)
		end
	end

	def update
		@tweet = Tweet.find(params[:tweet_id])
		@comment = @tweet.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to tweets_path(@tweet)
		else
			render 'edit'
		end
	end

	def destroy
		@tweet = Tweet.find(params[:tweet_id])
		@comment = @tweet.comments.find(params[:id])
		@comment.destroy
		redirect_to tweets_path
	end

	private
	  def comment_params
	    params.require(:comment).permit(:body)
	  end

end
