require 'rails_helper'

RSpec.describe 'Movie Search' do
  it 'allows users to search for movies', :vcr do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')

    visit user_discover_path(@user1.id)

    fill_in 'Search', with: 'someThing'
    click_button 'Find Movies'

    expect(page.status_code).to eq(200)
    expect(page).to have_content('40 Total Results')
    expect(page).to have_css("div", count: 40)
    within '#result-0' do
      expect(page).to have_content('Something the Lord Made - Rated 7.8')
    end
    within '#result-1' do
      expect(page).to have_content("Something Borrowed - Rated 6.3")
    end
  end
end
