require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, params: { user: { username: 'testuser', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
    end
    assert_redirected_to user_path(User.last)
    assert_equal "Welcome testuser, you have successfully signed up.", flash[:success]
  end

  test "should not create user with invalid params" do
    assert_no_difference('User.count') do
      post :create, params: { user: { username: '', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, params: { id: @user.id }
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch :update, params: { id: @user.id, user: { username: 'newusername' } }
    assert_redirected_to user_path(@user)
    assert_equal "Dear newusername, you have successfully updated your account.", flash[:success]
    @user.reload
    assert_equal 'newusername', @user.username
  end

  test "should not update user with invalid params" do
    log_in_as(@user)
    patch :update, params: { id: @user.id, user: { username: '' } }
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user.id }
    end
    assert_redirected_to users_path
    assert_equal "User account deleted successfully.", flash[:notice]
  end

  test "should redirect non-admin user to recipes_url on destroy" do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user.id }
    end
    assert_redirected_to recipes_url
    assert_nil session[:user_id]
    assert_equal "Your profile was successfully destroyed.", flash[:notice]
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
