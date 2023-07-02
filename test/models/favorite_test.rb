require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
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
    favorite = Favorite.new(
      value: 1,
      user: @user,
      recipe: @recipe
    )
    assert favorite.valid?
  end

  test 'should require a user' do
    favorite = Favorite.new(
      value: 1,
      user: @user,
      recipe: @recipe
    )
    assert_not favorite.valid?
    assert_includes favorite.errors[:user], "must exist"
  end

  test 'should require a recipe' do
    favorite = Favorite.new(
      value: 1,
      user: @user,
      recipe: @recipe
    )
    assert_not favorite.valid?
    assert_includes favorite.errors[:recipe], "must exist"
  end

  # test 'should have a unique combination of user and recipe' do
  #   Favorite.create(
  #     value: 1,
  #     user: @user,
  #     recipe: @recipe
  #   )

  #   duplicate_favorite = Favorite.new(
  #     value: 1,
  #     user: @user,
  #     recipe: @recipe
  #   )
  #   assert_not duplicate_favorite.valid?
  #   assert_includes duplicate_favorite.errors[:user_id], "has already been taken"
  # end
end
