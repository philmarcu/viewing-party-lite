# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :day }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :movie_title }
  end

  describe 'relationships' do
    it { should have_many(:users).through(:user_events) }
  end
end
