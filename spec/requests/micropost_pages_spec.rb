require 'spec_helper'

describe "MicropostPages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.should change(Micropost, :count).by(1)
      end
    end
    describe "microposts" do
      before do
        50.times do 
          content = Faker::Lorem.sentence(5)
          user.microposts.create!(content: content) 
        end
        @micropost_count = user.microposts.count
        #@counter_text = @micropost_count.to_s.pluralize("micropost")
        @counter_text = @micropost_count == 1 ? "micropost" : "microposts"

        visit root_path
      end

      describe "item counter" do
        it { should have_selector("span", text: "#{@micropost_count} #{@counter_text}") }
      end

      describe "pagination links" do
        it { should have_link('2') }  
      end
    end
  end

  describe "micropost view" do
    let(:user2) { FactoryGirl.create(:user) }
    before do
      10.times do
        content = Faker::Lorem.sentence(5)
        user2.microposts.create(content: content)
      end
      visit user_path(user2)
    end
    
    it { should have_selector('h1', text: user2.name) }
    it { should have_selector('h3', text: "Microposts (#{user2.microposts.count})") }
    it { should_not have_link('delete') }
  end
end
