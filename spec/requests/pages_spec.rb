require 'capybara/rspec'
require 'spec_helper'

describe 'Pages' do
  describe "home page" do
    it "should have the h1 'Sample App'" do
      visit root_path
      page.should have_selector('title', text: 'Sample App')
    end
  end
end
