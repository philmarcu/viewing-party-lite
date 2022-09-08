# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users show page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com',  password: "pwd")
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com',  password: "pwd")
    @user3 = User.create!(name: 'Mod Maude', email: 'admin@viewingparty.com',  password: "admin_pwd", role: 2)
  end

  def login(user)
    visit root_path
    click_on "Log In"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password
    click_on "Log In"
  end

  it 'has displays the users dashboard' do
    login(@user1)

    expect(page).to have_content("Jim Bob's Dashboard")
    expect(page).to have_button('Discover Movies')
  end

  it 'can let you log in as admin' do
    login(@user3)

    expect(page).to have_content("Mod Maude's Dashboard")
    expect(page).to have_button('Discover Movies')
  end
end
