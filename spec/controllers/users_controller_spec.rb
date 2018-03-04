require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #most_comments" do
    it "returns http success" do
      get :most_comments
      expect(response).to have_http_status(:success)
    end
  end

end
