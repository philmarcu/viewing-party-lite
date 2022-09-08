# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard' do
  def login(user)
    visit root_path
    click_on "Log In"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password
    click_on "Log In"
  end

  context 'user discover movie button' do
    it 'has a button to discover movies' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
      user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com', password: "pwd")

      login(user1)

      expect(page).to have_content("Jim Bob's Dashboard")
      expect(page).to_not have_content("Cary Berry's Dashboard")
      expect(page).to have_selector(:link_or_button, 'Discover Movies')
    end

    it 'can take you to the discover movie page from a users dashboard' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
      
      login(user1)

      curr_path = user_discover_path(user1.id)

      click_on 'Discover Movies'

      expect(page).to have_current_path(curr_path)
      expect(page).to have_content('Discover Movies')
      expect(page).to have_field(:search)
      expect(page).to have_selector(:link_or_button, 'Find Movies')
    end

    it 'can have view parties for a user' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
      event = Event.create!(duration: 112, day: Date.today, start_time: '7:00PM', movie_title: 'Something Borrowed')
      user_event = UserEvent.create!(user_id: user1.id, event_id: event.id)

      login(user1)

      expect(page).to have_content('Something Borrowed')
      expect(page).to have_content('7:00PM')
      expect(page).to have_content("#{Date.today}")
    end
  end
end

  # context 'sad path' do
  #   it 'will not show dashboard if invalid access' do
  #     user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
      
  #     visit user_path(user1.id)
  #     expect(page).to have_content("Invalid access to page, must be logged in")
  #   end
  # end
