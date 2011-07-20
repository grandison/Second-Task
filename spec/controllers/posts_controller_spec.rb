require 'spec_helper'
describe PostsController do
  describe "GET show" do
    it "should show post" do
      post = Post.create!(:user_id => 1, :category_id => 1,
                                         :text => "ich ni san",
                                         :topic => "sayonara")
      get :show, :id => post.id.to_s
      assigns(:post).should eq(post)
    end
  end
end

