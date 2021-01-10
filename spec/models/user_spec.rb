require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
    it {should have_one :merchant}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do 
  end
  
end