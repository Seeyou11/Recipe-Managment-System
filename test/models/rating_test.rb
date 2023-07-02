require 'test_helper'

class RatingTest < ActiveSupport::TestCase
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
    rating = Rating.new(value: 1, recipe: @recipe, user: @user)
    assert rating.valid?
  end

  test 'should have a value' do
    rating = Rating.new(recipe: @recipe, user: @user)
    assert_not rating.valid?
    assert_includes rating.errors[:value], "can't be blank"
  end

  test 'should belong to a recipe' do
    rating = Rating.new(value: 4, user: @user)
    assert_not rating.valid?
    assert_includes rating.errors[:recipe], "must exist"
  end

  test 'should belong to a user' do
    rating = Rating.new(value: 4, recipe: @recipe)
    assert_not rating.valid?
    assert_includes rating.errors[:user], "must exist"
  end
end
