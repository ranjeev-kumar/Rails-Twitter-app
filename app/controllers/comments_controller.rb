class CommentsController < ApplicationController
  before_action :set_tweet, only: [:edit, :create, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Yout comment is posted sucessfully!"
    else
      flash[:notice] = "Something went wrong, Try again!"
    end
    redirect_to tweets_path(@tweet)
  end

  def update
    @comment = @tweet.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to tweets_path(@tweet)
      flash[:notice] = "Yout comment is updated sucessfully!"
    else
      render 'edit'
      flash[:notice] = "Something went wrong, Try again!"
    end
  end

  def destroy
    @comment = @tweet.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Yout comment is removed sucessfully!"
    else
      flash[:notice] = "Something went wrong, Try again!"
    end
    redirect_to tweets_path
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
