require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "has posts" do
    assert !categories(:one).posts.empty?
  end
  test "don't save with empty name" do
    cat=Category.new
    assert !cat.save
  end
  test "don't save with not exists parent" do
    cat=Category.new
    cat.name="prodigy"
    cat.parent_id=28161717
    assert !cat.save
  end
end

