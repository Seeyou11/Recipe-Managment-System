require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    log_in_as(@user)
  end

  test "should create rating" do
    assert_difference('Rating.count') do
      post :create, params: { rating: { value: 4, recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
  end

  test "should not create rating when not logged in" do
    log_out
    assert_no_difference('Rating.count') do
      post :create, params: { rating: { value: 4, recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
  end

  test "should destroy rating" do
    rating = Rating.create(value: 4, recipe: @recipe, user: @user)
    assert_difference('Rating.count', -1) do
      delete :destroy, params: { id: rating.id }
    end
    assert_redirected_to recipes_url
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end
end
