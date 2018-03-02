require "rails_helper"
include Warden::Test::Helpers

describe "Movies requests", type: :request do
  context "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  context 'show movie' do
    let(:movie) { FactoryBot.create(:movie, :with_comments) }

    it 'and displays comments for movie' do
      visit movie_path(movie.id)
      expect(movie.comments.count).to eq(5)
    end
  end

  context 'as a logged in user' do
    let(:movie) { FactoryBot.create(:movie, :with_comments) }
    let(:user) { FactoryBot.create(:user) }

    before do
      login_as user, scope: :user
      visit "/movies/#{movie.id}"
    end

    it 'shows comment form' do
      expect(page).to have_css('#new_comment')
    end

    it 'done not allow to post empty comment' do
      fill_in "comment_content", with: ""
      click_button 'Submit'
      expect(page).to have_content("Content can't be blank")
    end

    it "allows to post new comment" do
      fill_in "comment_content", with: Faker::Lorem.sentence
      click_button 'Submit'
      expect(page).to have_content("Your comment was created!")
    end

    it "allows to delete your comment" do
      fill_in "comment_content", with: Faker::Lorem.sentence
      click_button 'Submit'
      click_link "Delete"
      expect(page).to have_content("Your comment was deleted")
    end

    it "cannot post two comments under same movie" do
      fill_in "comment_content", with: Faker::Lorem.sentence
      click_button 'Submit'
      fill_in "comment_content", with: Faker::Lorem.sentence
      click_button 'Submit'
      expect(user.comments.count).to eq(1)
    end

    it "can post new comment after deleting old one" do
      fill_in "comment_content", with: Faker::Lorem.sentence
      click_button 'Submit'
      click_link "Delete"
      expect(page).to have_content("Your comment was deleted")
      fill_in "comment_content", with: "My new comment"
      click_button 'Submit'
      expect(page).to have_content("My new comment")
    end

    it "done not allow to delete other user's comments" do
      expect(page).to_not have_css("delete")
    end
  end

  context "as not logged in user" do
    let(:movie) { FactoryBot.create(:movie, :with_comments) }

    it "do not show comment form" do
      visit "/movies/#{movie.id}"
      expect(page).to_not have_css("#new_comment")
    end
  end
end
