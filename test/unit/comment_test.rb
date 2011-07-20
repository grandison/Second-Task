require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "belongs to user" do
    assert_not_nil comments(:one).user
  end
  test "belongs to post" do
    assert_not_nil comments(:one).post
  end
  test "don't save with empty text" do
    com=Comment.new
    assert !com.save
  end
end

