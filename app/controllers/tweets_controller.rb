class TweetsController < ApplicationController

	before_action :validate_edit, only: [:edit]

	def index
		@tweets = Tweet.all
		@tweet = Tweet.new
	end

	# GET /tweets/:id/edit
	def edit
		@tweet = Tweet.find(params[:id])
	end

	def create
		@tweet = current_user.tweets.build(tweet_params)
  	@tweet.save
  	redirect_to tweets_path(@tweet)
	end

	def update
		@tweet = Tweet.find(params[:id])
		if @tweet.update(tweet_params)
			redirect_to tweets_path(@tweet)
		else
			render 'edit'
		end
	end

	def destroy
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect_to tweets_path(@tweet)
	end

	def retweet
		@body = Tweet.find(params[:id]).body
		@tweet = current_user.tweets.build(body: @body)
  	@tweet.save
  	redirect_to tweets_path(@tweet)
	end

	private
	  def tweet_params
	    params.require(:tweet).permit(:body)
	  end

	 def validate_edit
	 	@tweet = Tweet.find(params[:id])
	 	unless current_user.id == @tweet.user_id
	      flash[:notice] = "You don't have access to edit!"
	      redirect_to tweets_path(params[:id])
	      return
    	end
	 end

end
