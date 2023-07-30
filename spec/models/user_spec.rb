require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "validates presence of email" do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "validates uniqueness of email" do
      existing_user = FactoryBot.create(:user, email: "user@example.com")
      user = FactoryBot.build(:user, email: "user@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end
end
