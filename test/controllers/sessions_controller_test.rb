require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session" do
    post :create, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    assert_equal @user.id, session[:user_id]
    assert_equal "Logged in successfully", flash[:success]
  end

  test "should redirect admin to users_url on login" do
    @user.update(admin: true)
    post :create, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to users_url
  end

  test "should redirect non-admin to user_url on login" do
    @user.update(admin: false)
    post :create, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
  end

  test "should not create session with invalid credentials" do
    post :create, params: { session: { email: @user.email, password: 'invalid_password' } }
    assert_redirected_to login_path
    assert_nil session[:user_id]
    assert_equal "Invalid email or password. Please try again.", flash[:error]
  end

  test "should destroy session and log out user" do
    log_in_as(@user)
    delete :destroy
    assert_redirected_to login_path
    assert_nil session[:user_id]
    assert_equal "You have successfully logged out.", flash[:success]
  end

  private

  def log_in_as(user)
    session[:user_id] = user.id
  end
end
