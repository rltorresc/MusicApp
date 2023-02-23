require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6).allow_nil }
  end

  describe "instance methods" do
    describe "#is_password?" do
      let(:user) { User.create(email: "user@example.com", password: "password") }
  
      it { expect(user.is_password?("password")).to be true }
      it { expect(user.is_password?("wrong_password")).to be false }
    end

    describe "#reset_session_token!" do
      let(:user) { User.create(email: "user@example.com", password: "password") }
      it "changes the session token and saves the changes" do
        old_session_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(old_session_token)
        expect(user.reload.session_token).not_to eq(old_session_token)
      end
    end

    describe "::find_by_credentials" do
      let(:user) { User.create(email: "user@example.com", password: "password") }
      it "returns the user if the credentials are correct" do
        expect(User.find_by_credentials(user.email, "password")).to eq(user)
      end
      it "returns nil if the credentials are incorrect" do
        expect(User.find_by_credentials(user.email, "wrong_password")).to be_nil
      end
      it "returns nil if the user doesn't exist" do
        expect(User.find_by_credentials("wrong_email", "password")).to be_nil
      end
    end
  end

end
