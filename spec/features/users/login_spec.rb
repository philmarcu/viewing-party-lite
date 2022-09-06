require 'rails_helper'

RSpec.describe 'login user page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com',  password: "pwd")
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com',  password: "pwd")

    visit login_path
  end

  context 'happy path' do
    it "can log in with valid credentials" do
      fill_in :name, with: @user1.name
      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password
      fill_in :password_confirmation, with: @user1.password
  
      click_on "Log In"
  
      expect(current_path).to eq(user_path(@user1.id))
  
      expect(page).to have_content("Welcome, Jim Bob")
    end
  end

  context 'sad path' do
    it 'shows error if log-in info is incorrect' do
      fill_in :name, with: @user1.name
      fill_in :email, with: @user2.email
      fill_in :password, with: "pwd"
      fill_in :password_confirmation, with: "pwd"

      click_on "Log In"

      expect(page).to have_content("Error - Could'nt find Name or Email")
    end

    it 'shows different error if password is wrong' do
      fill_in :name, with: @user2.name
      fill_in :email, with: @user2.email
      fill_in :password, with: "blah"
      fill_in :password_confirmation, with: "blah"

      click_on "Log In"

      expect(page).to have_content("Error - Incorrect Password")
    end

    it 'shows different error if passwords do not match' do
      fill_in :name, with: @user2.name
      fill_in :email, with: @user2.email
      fill_in :password, with: "pwd"
      fill_in :password_confirmation, with: "blah"

      click_on "Log In"

      expect(page).to have_content("Error - Passwords must match")
    end
  end
end