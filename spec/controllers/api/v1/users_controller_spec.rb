require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    context 'user with such id exists' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        get :show, id: @user.id, format: :json
      end

      it "returns info about user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user.email
      end

      it { should respond_with 200 }
    end

    context 'user with such id doesnt exists' do
      before(:each) do
        get :show, id: -1, format: :json
      end

      it { should respond_with 404 }
    end
  end

  describe 'GET #index' do
    pending "Find a way to test GET #index method"

    before(:each) do
      @users_list = []
      5.times { @users_list << FactoryGirl.create(:user) }
      get :index, format: :json
    end

    it "should return users list" do
      # users_list_response = JSON.parse(response.body)
      # expect(users_list_response).to equal(User.all.as_json)
    end

    it { should respond_with 200 }
  end

  describe 'DELETE #destroy' do
    context 'user with such id exists' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        delete :destroy, id: @user.id, format: :json
      end

      it 'should return message' do
        user_delete_response = json_response
        expect(user_delete_response.keys).to include(:message)
      end

      it { should respond_with 204 }
    end

    context 'user with such id doesnt exists' do
      before(:each) do
        delete :destroy, id: -1, format: :json
      end

      it 'should return message that user is not found' do
        user_delete_response = json_response
        expect(user_delete_response.keys).to include(:message)
      end

      it { should respond_with 404 }
    end
  end

  describe 'PUT #update' do
    context 'when user exists' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @updated_user_params = FactoryGirl.attributes_for(:user)
      end

      context 'when update data is correct' do
        before(:each) do
          @updated_user_params[:email] = 'abc12345@simplemail.com'
          put :update, id: @user.id, user: @updated_user_params, format: :json
        end

        it 'should return updated user' do
          updated_user = json_response
          expect(updated_user[:email]).to eql(@updated_user_params[:email])
        end

        it { should respond_with 201 }
      end

      context 'when update data is not correct' do
        before(:each) do
          @updated_user_params[:email] = ''
          put :update, id: @user.id, user: @updated_user_params, format: :json
        end

        it 'should return errors' do
          request_response = json_response
          expect(request_response).to have_key(:errors)
        end

        it { should respond_with 400 }
      end

    end

    context 'when user doesnt exists' do
      before(:each) do
        put :update, id: -1, user: User.new.as_json, format: :json
      end

      it 'should have message' do
        request_response = json_response
        expect(request_response).to have_key(:message)
      end

      it { should respond_with 404 }
    end
  end

  describe 'POST #create' do
    context 'when user params are correct' do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for(:user)
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the json representation of user just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context 'when user params are not correct' do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for(:user)
        @user_attributes[:password] = "abc"
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders errors" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  after(:all) do
    User.delete_all
  end
end
