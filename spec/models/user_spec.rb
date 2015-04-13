require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:birthdate) }
  it { should validate_uniqueness_of(:auth_token) }

  describe "FactoryGirl model" do
    it "should be valid" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end
  end

  describe "#generate_authentication_token!" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end
end
