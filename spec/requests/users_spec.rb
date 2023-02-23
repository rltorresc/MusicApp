require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #new" do
    it "renders the new template" do
      get new_user_url
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post '/users', params: { user: {email: "", password: "" }}
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(new_user_url)
      end
      it "validates that the password is at least 6 characters long" do
        post '/users', params: { user: {email: "email@exampl.com", password: "12345"}}
        expect(response).to redirect_to(new_user_url)
      end
    end

    context "with valid params" do
      it "redirects user to notes index on success" do 
        post '/users', params: { user: {email: "email@exampl.com", password: "password"}}
        expect(response).to redirect_to(bands_url)
      end
    end

  end
end
