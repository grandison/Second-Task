require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "belongs to category" do
    assert_not_nil posts(:post1).category
  end
  test "belongs to user" do
    assert_not_nil posts(:post1).user
  end
  test "has comments" do
    assert !posts(:post1).comments.empty?
  end
end

