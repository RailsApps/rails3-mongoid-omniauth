require 'spec_helper'

describe UsersController do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "Get 'show' for non-logged in user" do
    it "redirects user to the root path to login" do
      session[:user_id] = nil
      get 'show', :id => @user.id
      response.should redirect_to(root_path)
    end
  end

  describe "Get 'show' for another user" do
    it "redirects user to root path with access denied" do
      @user2 = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      get 'show', :id => @user2
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'show' for logged in user" do
    it "returns http success" do
      session[:user_id] = @user.id
      get 'show', :id => @user
      response.should be_success
    end
  end

  describe "GET edit" do
    it "returns http success" do
      session[:user_id] = @user.id
      get 'edit', :id => @user
      response.should be_success
    end
  end

  describe "PUT update" do
    it "redirects user to @user" do
      session[:user_id] = @user.id
      put 'update', :id => @user, :user => {:name => "ted"}
      response.should redirect_to(@user)
    end
  end

  describe "PUT update" do
    it "with an error renders edit template" do
      session[:user_id] = @user.id
      put 'update', :id => @user, :user => {:name => ''}
      response.should render_template(:edit)
    end
  end

end
