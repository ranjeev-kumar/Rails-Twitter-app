class TweetsController < ApplicationController

  before_action :validate_edit, only: [:edit]
  before_action :set_tweet, only: [:edit, :update, :destroy]

  # GET /tweets/index
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  # GET /tweets/:id/edit
  def edit
  end

  # POST /tweets/create
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:alert] = "Yout tweet is posted sucessfully!"
    else
      flash[:alert] = "Something went wrong, Try again!"
    end
    redirect_to tweets_path(@tweet)
  end

  # PATCH /tweets/:id/update
  def update
    if @tweet.update(tweet_params)
      redirect_to tweets_path(@tweet)
      flash[:alert] = "You tweet is updated sucessfully!"
    else
      render 'edit'
      flash[:alert] = "Something went wrong, Try again!"
    end
  end

  # DELETE /tweets/:id/destroy
  def destroy
    if @tweet.destroy
      flash[:alert] = "You tweet is removed sucessfully!"
    else
      flash[:alert] = "Something went wrong, Try again!"
    end
    redirect_to tweets_path(@tweet)
  end

  # POST /tweets/:id/retweet
  def retweet
    @body = Tweet.find(params[:id]).body
    @tweet = current_user.tweets.build(body: @body)
    if @tweet.save
      flash[:alert] = "You retweet sucessfully!"
    else
      flash[:alert] = "Something went wrong, Try again!"
    end
    redirect_to tweets_path()
  end

  private
    # Strong params for tweet
    def tweet_params
      params.require(:tweet).permit(:body)
    end

    def validate_edit
      @tweet = Tweet.find(params[:id])
      unless current_user.id == @tweet.user_id
        flash[:alert] = "You don't have access to edit!"
        redirect_to tweets_path
        return
      end
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

end
