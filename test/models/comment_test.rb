require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'testuser', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    @category = Category.create(name: 'Example Category', description: 'Example description', user_id: @user)
    @recipe = Recipe.new(
      title: 'Example Recipe',
      description: 'Example description',
      preparation_steps: 'Example preparation steps',
      user: @user,
      category: @category
    )
  end

  test 'should be valid' do
    comment = Comment.new(
      content: "nice comment",
      recipe_id: @recipe,
      user_id: @user
    )
    assert comment.valid?
  end

  test 'should have a recipe' do
    comment = Comment.new(
      content: "nice comment",
      recipe_id: @recipe,
      user_id: @user
    )
    assert_not comment.valid?
    assert_includes comment.errors[:recipe], "must exist"
  end

  test 'should have a user' do
    comment = Comment.new(
      content: "nice comment",
      recipe_id: @recipe,
      user_id: @user
    )
    assert_not comment.valid?
    assert_includes comment.errors[:user], "must exist"
  end
end
