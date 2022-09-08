require 'rails_helper'

RSpec.describe 'Movie Search' do
  it 'allows users to search for movies', :vcr do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com',  password: "pwd")
    movie1 = MovieFacade.movie_details(49_022)

    visit user_discover_path(@user1.id)

    fill_in 'Search', with: 'someThing'
    click_button 'Find Movies'

    expect(page.status_code).to eq(200)
    expect(page).to have_content('40 Total Results')
    expect(page).to have_css("div", count: 40)
    
    within "#result-#{movie1.id}" do
      expect(page).to have_content('Something Borrowed')
    end
  end
end
