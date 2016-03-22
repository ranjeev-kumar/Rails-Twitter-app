require 'rails_helper'

describe UsersController, type: :controller do

  describe "response of action's for authenticated super user" do
    
    before do
      @current_user = FactoryGirl.create(:user)
      sign_in @current_user
    end

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'should render index page' do
        get :index
        expect(response).to render_template('index')
      end
    end

    describe "GET 'edit'" do
      before do
        @user = FactoryGirl.create(:user)
      end

      it "returns http success" do
        get :edit, {id: @user.id}
        expect(response).to be_success
      end

      it "should render edit page" do
        get :edit, {id: @user.id}
        expect(response).to render_template('edit')
      end
    end

    describe "PUT 'update'" do
      before do
        @user = FactoryGirl.create(:user)
      end

      id "returns to user's show page after success" do
        put :update,  {user:
          { password: '123456789', password_confirmation: '123456789', reset_password_sent: false},
          id: @current_user.id
        }
        expect(response).to redirect_to(dashboard_users_path)
        is_expected.to set_the_flash[:notice].to('Your password has been successfully updated.')
      end
    end
  end
end
