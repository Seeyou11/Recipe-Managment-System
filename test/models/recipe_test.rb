require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  fixtures :users, :categories, :recipes
  def setup
    @user = users(:one)   
    @category = categories(:one) 
    @recipe = recipes(:one) 
  end

  test 'should be valid' do
    assert @recipe.valid?
  end

  test 'title should be present' do
    @recipe.title = ' '
    assert_not @recipe.valid?
  end

  test 'title should have minimum length' do
    @recipe.title = 'a' * 6
    assert_not @recipe.valid?
  end

  test 'title should have maximum length' do
    @recipe.title = 'a' * 101
    assert_not @recipe.valid?
  end

  test 'description should be present' do
    @recipe.description = ' '
    assert_not @recipe.valid?
  end

  test 'description should have minimum length' do
    @recipe.description = 'a' * 9
    assert_not @recipe.valid?
  end

  test 'description should have maximum length' do
    @recipe.description = 'a' * 301
    assert_not @recipe.valid?
  end

  test 'preparation_steps should be present' do
    @recipe.preparation_steps = ' '
    assert_not @recipe.valid?
  end

  test 'preparation_steps should have minimum length' do
    @recipe.preparation_steps = 'a' * 9
    assert_not @recipe.valid?
  end

  test 'preparation_steps should have maximum length' do
    @recipe.preparation_steps = 'a' * 301
    assert_not @recipe.valid?
  end

  test 'should belong to a user' do
    assert_respond_to @recipe, :user
  end

  test 'should belong to a category' do
    assert_respond_to @recipe, :category
  end

  test 'should have many ratings' do
    assert_respond_to @recipe, :ratings
  end

  test 'should have many comments' do
    assert_respond_to @recipe, :comments
  end

  test 'should have one attached file' do
    assert_respond_to @recipe, :file
  end

  test 'should have many favorites' do
    assert_respond_to @recipe, :favorites
  end

  test 'should have many favorited_by users' do
    assert_respond_to @recipe, :favorited_by
  end
end
