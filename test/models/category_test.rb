  require 'test_helper'

  class CategoryTest < ActiveSupport::TestCase
    
    fixtures :users, :categories

    def setup
    @user = users(:one) 
    @category = categories(:one) 
    @category.user = @user
    end

    test 'should be valid' do
      assert @category.valid?
    end

    test 'name should be present' do
      @category.name = ' '
      assert_not @category.valid?
    end

    test 'name should be unique' do
      duplicate_category = @category.dup
      @category.save
      assert_not duplicate_category.valid?
    end

    test 'name should have minimum length' do
      @category.name = 'a' * 2
      assert_not @category.valid?
    end

    test 'name should have maximum length' do
      @category.name = 'a' * 26
      assert_not @category.valid?
    end

    test 'should have recipes' do
      assert_respond_to @category, :recipes
    end

    test 'should belong to a user' do
      assert_respond_to @category, :user
    end
  end
