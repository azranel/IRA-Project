require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @user_attributes = FactoryGirl.attributes_for(:user)
      @user = User.create(@user_attributes)
    end

    context 'when credintials are correct' do
      before(:each) do
        credintials = { email: @user.email, password: @user_attributes[:password] }
        post :create, { session: credintials }, format: :json
      end

      it 'returns the user record' do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token
      end

      it { should respond_with 200}
    end

    context 'when credintials are not correct' do
      before(:each) do
        credintials = { email: @user.email, password: 'this is wrong password' }
        post :create, { session: credintials }, format: :json
      end

      it 'returns errors' do
        expect(json_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryGirl.create :user
      sign_in @user
      delete :destroy, id: @user.auth_token
    end

    it { should respond_with 204 }
  end
end
