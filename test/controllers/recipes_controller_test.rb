require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    log_in_as(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get show" do
    get :show, params: { id: @recipe.id }
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, params: { recipe: { title: "New Recipe", description: "Recipe description", preparation_steps: "Steps", category_id: categories(:one).id } }
    end
    assert_redirected_to recipes_url
  end

  test "should get edit" do
    get :edit, params: { id: @recipe.id }
    assert_response :success
  end

  test "should update recipe" do
    patch :update, params: { id: @recipe.id, recipe: { title: "Updated Recipe" } }
    assert_redirected_to recipes_url
    @recipe.reload
    assert_equal "Updated Recipe", @recipe.title
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, params: { id: @recipe.id }
    end
    assert_redirected_to recipes_url
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
