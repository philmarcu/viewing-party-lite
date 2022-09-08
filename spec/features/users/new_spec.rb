# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'register page page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com',  password: "pwd")
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com',  password: "pwd")

    visit '/register'
  end

  context 'happy path' do
    it 'can register a user by unique email' do
      fill_in 'Name', with: 'Tyler'
      fill_in 'Email', with: 'tyler@user.com'
      fill_in 'Password', with: 'pwd'
      fill_in 'Password Confirmation', with: 'pwd'
      click_on('Submit')

      expect(current_path).to eq("/users/#{User.last.id}")
      expect(page).to have_content("Welcome Tyler")
    end
  end

  context 'sad path' do
    it 'displays an error message if user fails to fill in parameters' do
      fill_in 'Name', with: nil
      fill_in 'Email', with: 'tater@gmail.com'
      fill_in 'Password', with: ''
      fill_in 'Password Confirmation', with: 'pwd'
      click_on('Submit')

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    it 'displays error message if passwords do not match' do
      fill_in 'Name', with: "yep"
      fill_in 'Email', with: 'tater@gmail.com'
      fill_in 'Password', with: 'pwd'
      fill_in 'Password Confirmation', with: 'wrong_pwd'
      click_on('Submit')

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
