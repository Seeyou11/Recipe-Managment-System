require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    log_in_as(@user)
  end

  test "should create favorite" do
    assert_difference('Favorite.count') do
      post :create, params: { favorite: { recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  test "should not create duplicate favorite" do
    @user.favorite_recipes << @recipe
    assert_no_difference('Favorite.count') do
      post :create, params: { favorite: { recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  test "should destroy favorite" do
    @user.favorite_recipes << @recipe
    assert_difference('Favorite.count', -1) do
      delete :destroy, params: { favorite: { recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  test "should not destroy non-existent favorite" do
    assert_no_difference('Favorite.count') do
      delete :destroy, params: { favorite: { recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
