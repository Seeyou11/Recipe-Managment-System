require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @recipe = recipes(:one)
    @comment = comments(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index, params: { recipe_id: @recipe.id }
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:comments)
  end

  test "should redirect index when recipe not found" do
    get :index, params: { recipe_id: 999 }
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end

  test "should get show" do
    get :show, params: { id: @comment.id }
    assert_response :success
    assert_template :show
    assert_not_nil assigns(:comment)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:comment)
  end

  test "should create comment" do
    log_in_as(@user)
    assert_difference('Comment.count') do
      post :create, params: { comment: { content: "Test Comment", recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  test "should not create comment when not logged in" do
    assert_no_difference('Comment.count') do
      post :create, params: { comment: { content: "Test Comment", recipe_id: @recipe.id } }
    end
    assert_redirected_to recipes_url
    assert_not flash.empty?
  end

  test "should get user comments" do
    @user = users(:two)
    get :user_comments, params: { user_id: @user.id }
    assert_response :success
    assert_template :user_comments
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:comments)
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
