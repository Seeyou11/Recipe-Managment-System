require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :recipes, :users, :comments
  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    @comment = comments(:one)
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'should have a recipe' do
    @comment.recipe_id = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:recipe], "must exist"
  end

  test 'should have a user' do
    @comment.user_id = nil
    assert_not @comment.valid?
    assert_includes @comment.errors[:user], "must exist"
  end

end
