require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  fixtures :users, :recipes, :ratings

  def setup
    @user = users(:one)
    @recipe = recipes(:one)
    @rating = ratings(:one)
  end

  test 'should be valid' do
    assert @rating.valid?
  end

  test 'should require a value' do
    @rating.value = nil
    assert_not @rating.valid?
    assert @rating.errors[:value].include?("can't be blank")
  end

  test 'should belong to a recipe' do
    @rating.recipe = nil
    assert_not @rating.valid?
    assert @rating.errors[:recipe].include?("must exist")
  end

  test 'should belong to a user' do
    @rating.user = nil
    assert_not @rating.valid?
    assert @rating.errors[:user].include?("must exist")
  end
end
