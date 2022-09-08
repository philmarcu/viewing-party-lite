# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com', password: "pwd")

    visit root_path
  end

  def login(user)
    visit root_path
    click_on "Log In"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password
    click_on "Log In"
  end

  it 'can direct to create a new user' do
    click_button('Create a New User')
    expect(current_path).to eq('/register')
  end

  it 'has a log-in link for users' do
    click_on "Log In"

    expect(page).to have_current_path(login_path)
    expect(page).to_not have_current_path(logout_path)
    expect(find('form')).to have_content('Email')
    expect(find('form')).to have_content('Password')
    expect(find('form')).to have_content('Confirm Password')
  end

  it 'has a log-out link for users' do
   login(@user1)
    visit root_path

    expect(page).to have_content("Welcome back Jim Bob")
    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Log In")
  end
end

# @user1.authenticate(@user1.password)
# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)