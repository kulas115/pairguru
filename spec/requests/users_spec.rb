require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "most comments list" do
    before do
      create_list(:user, 20, :with_comments)
    end
    it "shows 10 most active commenters" do
      visit '/users/most_comments'
      expect(page).to have_selector('.place', count: 10)
    end
  end
end
