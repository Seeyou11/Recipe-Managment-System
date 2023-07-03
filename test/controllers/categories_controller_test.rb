require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = categories(:one)
    @user = users(:one)
  end

  test "should get new" do
    log_in_as(@admin)
    get :new
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to categories_url
    assert_not flash.empty?
  end

  test "should create category" do
    log_in_as(@admin)
    assert_difference('Category.count') do
      post :create, params: { category: { name: "Test Category", description: "Test Description" } }
    end
    assert_redirected_to categories_url
    assert_not flash.empty?
  end

  test "should redirect create when not logged in" do
    assert_no_difference('Category.count') do
      post :create, params: { category: { name: "Test Category", description: "Test Description" } }
    end
    assert_redirected_to categories_url
    assert_not flash.empty?
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_select "h1", "Categories"
  end

  test "should get show" do
    get :show, params: { id: @category.id }
    assert_response :success
    assert_select "h1", @category.name
  end

  test "should get edit" do
    log_in_as(@admin)
    get :edit, params: { id: @category.id }
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @category.id }
    assert_redirected_to categories_url
    assert_not flash.empty?
  end

  test "should update category" do
    log_in_as(@admin)
    patch :update, params: { id: @category.id, category: { name: "Updated Category", description: "Updated Description" } }
    assert_redirected_to category_url(@category)
    @category.reload
    assert_equal "Updated Category", @category.name
    assert_equal "Updated Description", @category.description
  end

  test "should redirect update when not logged in" do
    patch :update, params: { id: @category.id, category: { name: "Updated Category", description: "Updated Description" } }
    assert_redirected_to categories_url
    assert_not flash.empty?
    @category.reload
    assert_not_equal "Updated Category", @category.name
    assert_not_equal "Updated Description", @category.description
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
