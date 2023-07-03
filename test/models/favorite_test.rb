require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  fixtures :users,  :recipes, :favorites

  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    @favorite = favorites(:one)
  end

  test 'should be valid' do
    assert @favorite.valid?
  end

  test 'should require a user' do
    @favorite.user = nil
    assert_not @favorite.valid?
    assert_includes @favorite.errors[:user], "must exist"
  end

  test 'should require a recipe' do
    @favorite.recipe = nil
    assert_not @favorite.valid?
    assert_includes @favorite.errors[:recipe], "must exist"
  end
end
