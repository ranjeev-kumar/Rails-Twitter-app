require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  
  describe "GET #index" do  
    before do 
      @current_user = FactoryGirl.create(:user)
      sign_in @current_user
      @tweet = FactoryGirl.create(:tweet)
    end
    
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns all tweets as @tweets" do
      get :index
      expect(assigns(:tweets)).to match_array([@tweet])
    end
  end

  describe "GET #edit" do
    before do 
      @current_user = FactoryGirl.create(:user)
      sign_in @current_user
      @tweet = FactoryGirl.create(:tweet, user: @current_user)
    end

    it "returns http success" do
      get :edit, {id: @tweet.id}
      expect(response).to be_success
    end

    it "should not edit other's tweet" do
      tweet = FactoryGirl.create(:tweet)
      get :edit, {id: tweet.id}
      expect(response).to redirect_to(tweets_path)
    end

    it "redirect to tweet#index and should show alert message" do
      tweet = FactoryGirl.create(:tweet)
      get :edit, {id: tweet.id}
      expect(controller).to set_flash[:alert].to("You don't have access to edit!")
      expect(response).to redirect_to(tweets_path)
    end
  end

  describe "response if user is not login" do

    it "redirect_to the login template" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end 
  end
end
