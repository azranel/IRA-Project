require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:birthdate) }

  describe "FactoryGirl model" do
    it "should be valid" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end
  end
end
