require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def setup
    @user = users(:one)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  # test 'username should be present' do
  #   @user.username = ' '
  #   assert_not @user.valid?
  # end

  # test 'username should have minimum length' do
  #   @user.username = 'aa'
  #   assert_not @user.valid?
  # end

  # test 'username should have maximum length' do
  #   @user.username = 'a' * 26
  #   assert_not @user.valid?
  # end

  # test 'username should be unique' do
  #   duplicate_user = @user.dup
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end

  # test 'username should be case-insensitive unique' do
  #   duplicate_user = @user.dup
  #   duplicate_user.username = @user.username.upcase
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end

  # test 'email should be present' do
  #   @user.email = ' '
  #   assert_not @user.valid?
  # end

  # test 'email should have maximum length' do
  #   @user.email = 'a' * 26 + '@example.com'
  #   assert_not @user.valid?
  # end

  # test 'email should be unique' do
  #   duplicate_user = @user.dup
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end

  # test 'email should be case-insensitive unique' do
  #   duplicate_user = @user.dup
  #   duplicate_user.email = @user.email.upcase
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end

  # test 'email should have valid format' do
  #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  #   valid_addresses.each do |valid_address|
  #     @user.email = valid_address
  #     assert @user.valid?
  #   end
  # end

  # test 'email should reject invalid format' do
  #   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
  #   invalid_addresses.each do |invalid_address|
  #     @user.email = invalid_address
  #     assert_not @user.valid?
  #   end
  # end

  # test 'password should be present' do
  #   @user.password = ' ' * 6
  #   assert_not @user.valid?
  # end

  # test 'password should have minimum length' do
  #   @user.password = 'a' * 5
  #   assert_not @user.valid?
  # end

  # test 'password confirmation should be present' do
  #   @user.password_confirmation = ' ' * 6
  #   assert_not @user.valid?
  # end


  # # Testing associations

  # test 'should have many recipes' do
  #   assert_respond_to @user, :recipes
  # end

  # test 'should have many categories' do
  #   assert_respond_to @user, :categories
  # end

  # test 'should have many ratings' do
  #   assert_respond_to @user, :ratings
  # end

  # test 'should have many comments' do
  #   assert_respond_to @user, :comments
  # end

  # test 'should have one attached file' do
  #   assert_respond_to @user, :file
  # end

  # test 'should have many favorites' do
  #   assert_respond_to @user, :favorites
  # end

  # test 'should have many favorite_recipes' do
  #   assert_respond_to @user, :favorite_recipes
  # end
end
