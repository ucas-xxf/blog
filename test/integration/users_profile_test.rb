require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  # test "profile display" do
  #   get user_path(@user)

  #    assert_template 'users/showuser'
    
  #   assert_select 'h1', text: @user.name
  #   assert_select 'h1>img.gravatar'

  #   assert_match @user.microposts.count.to_s, response.body
    
  # end
end
