require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end

    # check prence of field in signup form
    describe "Check presence of signup field" do    
      before { get :new }

      it "should have a name field" do
        response.should have_selector("input[name='user[name]'][type='text']")
      end

      it "should have a email field" do
        response.should have_selector("input[name='user[email]'][type='text']")
      end

      it "should have a password field" do
        response.should have_selector("input[name='user[password]'][type='password']")
      end

      it "should have a password confirmation field" do
        response.should have_selector("input[name='user[password_confirmation]'][type='password']")
      end
    end
  end
  
end
