require 'rails_helper'

RSpec.describe 'Movie_decorator' do
  it 'shows date in Year.month.day format' do
    movie = FactoryBot.create(:movie, released_at: "2017-05-16")

    expect(movie.decorate.formated_realeased_at).to eq("16.05.2017")
  end
end
