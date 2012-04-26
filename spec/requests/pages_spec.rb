require 'capybara/rspec'
require 'spec_helper'

describe 'Pages' do
  describe "home page" do
    it "should have the h1 'Sample App'" do
      visit root_path
      page.should have_selector('title', text: 'Sample App')
    end
  end

  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user, content: "Lorem")
      FactoryGirl.create(:micropost, user: user, content: "Ipsum")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
      end
    end

    describe "follower/following counts" do
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        other_user.follow!(user)
        visit root_path
      end

      it { should have_link("0 following", href: following_user_path(user)) }
      it { should have_link("1 follower", href: follower_user_path(user)) }
    end
  end
end
